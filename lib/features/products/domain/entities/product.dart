import 'package:equatable/equatable.dart';
// import 'package:cifarx/core/domain/entities/base_entity.dart';

class ProductListEntity extends Equatable {
  final List<ProductEntity> products;
  final int total;
  final int skip;
  final int limit;

  const ProductListEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [products, total, skip, limit];
}

// class ProductEntity extends BaseEntity {
//   final int? productId;
//   final String? title;
//   final String? description;
//   final String? category;
//   final double? price;
//   final double? discountPercentage;
//   final double? rating;
//   final int? stock;
//   final String? sku;
//   final String? warrantyInformation;
//   final String? shippingInformation;
//   final String? availabilityStatus;
//   final List<ReviewEntity>? reviews;
//   final String? returnPolicy;
//   final int? minimumOrderQuantity;
//   final List<String>? images;
//   final String? thumbnail;

//   const ProductEntity({
//     super.id,
//     super.createdAt,
//     super.updatedAt,
//     this.productId,
//     this.title,
//     this.description,
//     this.category,
//     this.price,
//     this.discountPercentage,
//     this.rating,
//     this.stock,
//     this.sku,
//     this.warrantyInformation,
//     this.shippingInformation,
//     this.availabilityStatus,
//     this.reviews,
//     this.returnPolicy,
//     this.minimumOrderQuantity,
//     this.images,
//     this.thumbnail,
//   });

//   @override
//   List<Object?> get props => [
//         ...super.props,
//         productId,
//         title,
//         description,
//         category,
//         price,
//         discountPercentage,
//         rating,
//         stock,
//         sku,
//         warrantyInformation,
//         shippingInformation,
//         availabilityStatus,
//         reviews,
//         returnPolicy,
//         minimumOrderQuantity,
//         images,
//         thumbnail,
//       ];
// }

// class ReviewEntity extends Equatable {
//   final int? rating;
//   final String? comment;
//   final String? date;
//   final String? reviewerName;
//   final String? reviewerEmail;

//   const ReviewEntity({
//     this.rating,
//     this.comment,
//     this.date,
//     this.reviewerName,
//     this.reviewerEmail,
//   });

//   @override
//   List<Object?> get props => [
//         rating,
//         comment,
//         date,
//         reviewerName,
//         reviewerEmail,
//       ];
// }

class MetaEntity extends Equatable {
  final String? createdAt;
  final String? updatedAt;
  final String? barcode;
  final String? qrCode;

  const MetaEntity({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  @override
  List<Object?> get props => [createdAt, updatedAt, barcode, qrCode];

  factory MetaEntity.fromJson(Map<String, dynamic> json) {
    return MetaEntity(
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      barcode: json['barcode'] as String?,
      qrCode: json['qrCode'] as String?,
    );
  }
}

class DimensionsEntity extends Equatable {
  final double? width;
  final double? height;
  final double? depth;

  const DimensionsEntity({this.width, this.height, this.depth});

  @override
  List<Object?> get props => [width, height, depth];

  factory DimensionsEntity.fromJson(Map<String, dynamic> json) {
    return DimensionsEntity(
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      depth: (json['depth'] as num?)?.toDouble(),
    );
  }
}

// Define ReviewEntity for product reviews
class ReviewEntity extends Equatable {
  final int? rating;
  final String? comment;
  final String? date;
  final String? reviewerName;
  final String? reviewerEmail;

  const ReviewEntity({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  @override
  List<Object?> get props => [
    rating,
    comment,
    date,
    reviewerName,
    reviewerEmail,
  ];

  factory ReviewEntity.fromJson(Map<String, dynamic> json) {
    return ReviewEntity(
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      date: json['date'] as String?,
      reviewerName: json['reviewerName'] as String?,
      reviewerEmail: json['reviewerEmail'] as String?,
    );
  }
}

class ProductEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? sku;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewEntity>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final List<String>? images;
  final String? thumbnail;
  final MetaEntity? meta;
  final DimensionsEntity? dimensions;

  const ProductEntity({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.sku,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.images,
    this.thumbnail,
    this.meta,
    this.dimensions,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    price,
    discountPercentage,
    rating,
    stock,
    sku,
    warrantyInformation,
    shippingInformation,
    availabilityStatus,
    reviews,
    returnPolicy,
    minimumOrderQuantity,
    images,
    thumbnail,
    meta,
    dimensions,
  ];

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      stock: json['stock'] as int?,
      sku: json['sku'] as String?,
      warrantyInformation: json['warrantyInformation'] as String?,
      shippingInformation: json['shippingInformation'] as String?,
      availabilityStatus: json['availabilityStatus'] as String?,
      reviews: (json['reviews'] as List?)
          ?.map((e) => ReviewEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      returnPolicy: json['returnPolicy'] as String?,
      minimumOrderQuantity: json['minimumOrderQuantity'] as int?,
      images: (json['images'] as List?)?.cast<String>(),
      thumbnail: json['thumbnail'] as String?,
      meta: json['meta'] != null ? MetaEntity.fromJson(json['meta']) : null,
      dimensions: json['dimensions'] != null
          ? DimensionsEntity.fromJson(json['dimensions'])
          : null,
    );
  }
}
