import 'package:cifarx/features/products/domain/usecases/get_paginated_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetPaginatedProductsUseCase getPaginatedProductsUseCase;

  ProductsBloc(this.getPaginatedProductsUseCase)
      : super(const ProductsState()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: ProductsStatus.loading));

    final result = await getPaginatedProductsUseCase(
      params: PaginationParams(
        limit: event.limit,
        skip: event.skip,
      ),
    );

    result.match(
      (failure) => emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (products) => emit(
        state.copyWith(
          status: ProductsStatus.success,
          products: event.isRefresh ? products : [...state.products, ...products],
        ),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message.isNotEmpty
        ? failure.message
        : 'Unexpected error occurred.';
  }
}
