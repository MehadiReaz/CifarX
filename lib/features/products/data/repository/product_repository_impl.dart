import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:cifarx/core/error/failures.dart';
import 'package:cifarx/core/error/error_handler.dart';
import 'package:cifarx/features/products/data/models/product.dart';
import 'package:cifarx/features/products/domain/entities/product.dart';
import '../../domain/repository/product_repository.dart';
import '../data_sources/remote/product_api_service.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService productApiService;
  final Logger _logger = Logger();

  ProductRepositoryImpl(this.productApiService);

  @override
  Future<Either<Failure, ProductListEntity>> getProducts({
    required int limit,
    required int skip,
    String? sort,
    String? order,
  }) async {
    try {
      final httpResponse = await productApiService.getProducts(
        limit: limit,
        skip: skip,
        sort: sort,
        order: order,
      );

      _logger.d('getProducts Response: ${httpResponse.data}');
      final requestUri = httpResponse.response.requestOptions.uri;
      _logger.d('API URL (getProducts): $requestUri');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final productListModel = ProductListModel.fromJson(httpResponse.data);
        // Since ProductModel extends ProductEntity, we can use them directly
        final entity = ProductListEntity(
          products: productListModel.products.cast<ProductEntity>(),
          total: productListModel.total,
          skip: productListModel.skip,
          limit: productListModel.limit,
        );
        return Right(entity);
      } else {
        return Left(
          ServerFailure(
            'HTTP Error: ${httpResponse.response.statusCode}',
            statusCode: httpResponse.response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('getProducts Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    } catch (e) {
      _logger.e('getProducts Unexpected Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProductListEntity>> searchProducts(
    String query, {
    int? limit,
    int? skip,
    String? sort,
    String? order,
  }) async {
    try {
      final httpResponse = await productApiService.searchProducts(
        query: query,
        limit: limit,
        skip: skip,
        sort: sort,
        order: order,
      );

      _logger.d('searchProducts Response: ${httpResponse.data}');
      final requestUri = httpResponse.response.requestOptions.uri;
      _logger.d('API URL (searchProducts): $requestUri');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final productListModel = ProductListModel.fromJson(httpResponse.data);
        // Since ProductModel extends ProductEntity, we can use them directly
        final entity = ProductListEntity(
          products: productListModel.products.cast<ProductEntity>(),
          total: productListModel.total,
          skip: productListModel.skip,
          limit: productListModel.limit,
        );
        return Right(entity);
      } else {
        return Left(
          ServerFailure(
            'HTTP Error: ${httpResponse.response.statusCode}',
            statusCode: httpResponse.response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('searchProducts Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    } catch (e) {
      _logger.e('searchProducts Unexpected Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    try {
      final httpResponse = await productApiService.getProductById(id: id);

      _logger.d('getProductById Response: ${httpResponse.data}');
      final requestUri = httpResponse.response.requestOptions.uri;
      _logger.d('API URL (getProductById): $requestUri');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final productModel = ProductModel.fromJson(httpResponse.data);
        return Right(productModel);
      } else {
        return Left(
          ServerFailure(
            'HTTP Error: ${httpResponse.response.statusCode}',
            statusCode: httpResponse.response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('getProductById Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    } catch (e) {
      _logger.e('getProductById Unexpected Error: $e');
      return Left(ErrorHandler.mapExceptionToFailure(e));
    }
  }
}
