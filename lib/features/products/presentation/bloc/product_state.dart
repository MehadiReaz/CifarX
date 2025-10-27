// States
part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? searchQuery;

  const ProductLoadSuccess(
    this.products, {
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.searchQuery,
  });

  ProductLoadSuccess copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? searchQuery,
  }) {
    return ProductLoadSuccess(
      products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props =>
      [products, hasReachedMax, isLoadingMore, searchQuery];
}

class ProductLoadFailed extends ProductState {
  final String message;

  const ProductLoadFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductDetailsLoading extends ProductState {}

class ProductDetailsLoaded extends ProductState {
  final ProductEntity product;

  const ProductDetailsLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDetailsError extends ProductState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
