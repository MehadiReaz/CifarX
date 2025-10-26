import 'package:cifarx/features/products/domain/entity/product_list_entity.dart';
import 'product_model.dart';

/// ----------------------
/// ProductListModel
/// ----------------------
class ProductListModel {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  const ProductListModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  /// Factory to parse JSON into data model
  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e))
          .toList() ??
          [],
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  /// Converts this model into a domain entity
  ProductListEntity toEntity() => ProductListEntity(
    products: products.map((e) => e.toEntity()).toList(),
    total: total,
    skip: skip,
    limit: limit,
  );
}
