import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductsEvent {
  final int limit;
  final int skip;
  final bool isRefresh;

  const FetchProducts({
    this.limit = 20,
    this.skip = 0,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [limit, skip, isRefresh];
}

class SearchProducts extends ProductsEvent {
  final String query;
  final int limit;
  final int skip;

  const SearchProducts({
    required this.query,
    this.limit = 20,
    this.skip = 0,
  });

  @override
  List<Object?> get props => [query, limit, skip];
}