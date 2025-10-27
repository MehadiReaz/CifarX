import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:cifarx/core/error/failures.dart';
import 'package:cifarx/core/error/error_handler.dart';
import 'package:cifarx/features/products/domain/entities/product.dart';
import 'package:cifarx/features/products/domain/usecases/get_products.dart';
import 'package:cifarx/features/products/domain/usecases/search_product.dart';
import 'package:cifarx/features/products/domain/usecases/get_product_by_id.dart';
import 'package:cifarx/features/products/domain/params/products_params.dart';
import 'package:cifarx/features/products/domain/params/product_search_params.dart';
import 'package:cifarx/features/products/domain/params/product_id_params.dart';

part 'product_events.dart';
part 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUsecase _getProductsUsecase;
  final SearchProductsUsecase _searchProductsUsecase;
  final GetProductByIdUsecase _getProductByIdUsecase;

  List<ProductEntity> _products = [];
  bool _hasReachedMax = false;
  String? _currentSearch;
  String? _currentSortBy;
  String? _currentOrder;

  ProductBloc(
    this._getProductsUsecase,
    this._searchProductsUsecase,
    this._getProductByIdUsecase,
  ) : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<SearchProductsEvent>(_onSearchProducts);
    on<LoadMoreProductsEvent>(_onLoadMoreProducts);
    on<SortProductsEvent>(_onSortProducts);
    on<ToggleWishlistEvent>(_onToggleWishlist);
    on<ClearSearchEvent>(_onClearSearch);
    on<GetProductDetailsEvent>(_onGetProductDetails);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductLoading) return;

    emit(ProductLoading());

    _products = [];
    _hasReachedMax = false;
    _currentSearch = null;
    _currentSortBy = event.sortBy;
    _currentOrder = event.order;

    final result = await _getProductsUsecase(
      ProductsParams(
        limit: event.limit ?? 10,
        skip: event.skip ?? 0,
        sort: event.sortBy,
        order: event.order,
      ),
    );

    result.fold(
      (failure) =>
          emit(ProductLoadFailed(ErrorHandler.getErrorMessage(failure))),
      (productListEntity) {
        _products = productListEntity.products;
        _hasReachedMax =
            productListEntity.products.length < (event.limit ?? 10);
        emit(ProductLoadSuccess(_products, hasReachedMax: _hasReachedMax));
      },
    );
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (_hasReachedMax || state is ProductLoading) return;

    emit(
      ProductLoadSuccess(
        _products,
        isLoadingMore: true,
        hasReachedMax: _hasReachedMax,
        searchQuery: _currentSearch,
      ),
    );

    Either<Failure, ProductListEntity> result;

    if (_currentSearch != null) {
      result = await _searchProductsUsecase(
        ProductSearchParams(
          query: _currentSearch!,
          limit: 10,
          skip: _products.length,
          sort: _currentSortBy,
          order: _currentOrder,
        ),
      );
    } else {
      result = await _getProductsUsecase(
        ProductsParams(
          limit: 10,
          skip: _products.length,
          sort: _currentSortBy,
          order: _currentOrder,
        ),
      );
    }

    result.fold(
      (failure) =>
          emit(ProductLoadFailed(ErrorHandler.getErrorMessage(failure))),
      (productListEntity) {
        _products.addAll(productListEntity.products);
        _hasReachedMax = productListEntity.products.length < 10;
        emit(
          ProductLoadSuccess(
            _products,
            hasReachedMax: _hasReachedMax,
            searchQuery: _currentSearch,
          ),
        );
      },
    );
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (event.query.isEmpty) {
      _onClearSearch(ClearSearchEvent(), emit);
      return;
    }

    emit(ProductLoading());

    _products = [];
    _hasReachedMax = false;
    _currentSearch = event.query;
    _currentSortBy = event.sortBy;
    _currentOrder = event.order;

    final result = await _searchProductsUsecase(
      ProductSearchParams(
        query: event.query,
        limit: event.limit ?? 10,
        skip: event.skip ?? 0,
        sort: event.sortBy,
        order: event.order,
      ),
    );

    result.fold(
      (failure) =>
          emit(ProductLoadFailed(ErrorHandler.getErrorMessage(failure))),
      (productListEntity) {
        _products = productListEntity.products;
        _hasReachedMax =
            productListEntity.products.length < (event.limit ?? 10);
        emit(
          ProductLoadSuccess(
            _products,
            hasReachedMax: _hasReachedMax,
            searchQuery: event.query,
          ),
        );
      },
    );
  }

  Future<void> _onSortProducts(
    SortProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    _currentSortBy = event.sortBy;
    _currentOrder = event.order;

    if (_currentSearch != null) {
      add(
        SearchProductsEvent(
          query: _currentSearch!,
          sortBy: event.sortBy,
          order: event.order,
        ),
      );
    } else {
      add(GetProductsEvent(sortBy: event.sortBy, order: event.order));
    }
  }

  void _onToggleWishlist(
    ToggleWishlistEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoadSuccess) {
      final currentState = state as ProductLoadSuccess;
      final updatedProducts = currentState.products.map((product) {
        if (product.id == event.productId) {
          // Since we don't have a copyWith method, we'll just return the same product
          // This wishlist feature would need to be implemented properly
          return product;
        }
        return product;
      }).toList();

      _products = updatedProducts;
      emit(currentState.copyWith(products: updatedProducts));
    }
  }

  void _onClearSearch(ClearSearchEvent event, Emitter<ProductState> emit) {
    _currentSearch = null;
    add(GetProductsEvent(sortBy: _currentSortBy, order: _currentOrder));
  }

  Future<void> _onGetProductDetails(
    GetProductDetailsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductDetailsLoading());
    try {
      final result = await _getProductByIdUsecase(
        ProductIdParams(id: int.parse(event.productId)),
      );
      result.fold(
        (failure) => emit(ProductDetailsError(failure.message)),
        (product) => emit(ProductDetailsLoaded(product)),
      );
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}
