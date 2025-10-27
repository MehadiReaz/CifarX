// Events
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsEvent extends ProductEvent {
  final int? limit;
  final int? skip;
  final String? sortBy;
  final String? order;

  const GetProductsEvent({
    this.limit,
    this.skip,
    this.sortBy,
    this.order,
  });

  @override
  List<Object?> get props => [limit, skip, sortBy, order];
}

class SearchProductsEvent extends ProductEvent {
  final String query;
  final int? limit;
  final int? skip;
  final String? sortBy;
  final String? order;

  const SearchProductsEvent({
    required this.query,
    this.limit,
    this.skip,
    this.sortBy,
    this.order,
  });

  @override
  List<Object?> get props => [query, limit, skip, sortBy, order];
}

class LoadMoreProductsEvent extends ProductEvent {}

class SortProductsEvent extends ProductEvent {
  final String sortBy;
  final String order;

  const SortProductsEvent({
    required this.sortBy,
    required this.order,
  });

  @override
  List<Object?> get props => [sortBy, order];
}

class ToggleWishlistEvent extends ProductEvent {
  final int productId;

  const ToggleWishlistEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class GetProductDetailsEvent extends ProductEvent {
  final String productId;

  const GetProductDetailsEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ClearSearchEvent extends ProductEvent {}
