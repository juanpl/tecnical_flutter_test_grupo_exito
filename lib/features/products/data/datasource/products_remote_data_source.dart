

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/models/category_model.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/models/product_model.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/entities.dart';

abstract class ProductsRemoteDataSource {
  Future<List<CategoryModel>> getCategoryList();
  Future<List<Product>> getProductList(int categoryId);
  Future<ProductModel> getProductInfo(int productId);
}

class ProductsAPIsSourceImpl implements ProductsRemoteDataSource {
  
  final Dio dio = Dio(); 

  @override
  Future<List<CategoryModel>> getCategoryList() async {
    try {

      final resp = await dio.get('https://api.escuelajs.co/api/v1/categories');
      final categories = (resp.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
      return categories;

    } on DioException catch (e) {
      if (e.response?.statusCode != null &&
          e.response!.statusCode! >= 500 &&
          e.response!.statusCode! < 600) {
        throw ServerFailure();
      } else {
        throw NetworkFailure();
      }
    } catch (e) {
      throw UnexpectedError();
    }
  }

  @override
  Future<ProductModel> getProductInfo(int productId) async {
    try {

      final resp = await dio.get('https://api.escuelajs.co/api/v1/products/$productId');
      final product = ProductModel.fromJson(resp);
      return product;  

    } on DioException catch (e) {
        if (e.response?.statusCode != null &&
            e.response!.statusCode! >= 500 &&
            e.response!.statusCode! < 600) {
          throw ServerFailure();
        } else {
          throw  Left(NetworkFailure());
        }
    } catch (e) {
      throw Left(UnexpectedError());
    }
  }

  @override
  Future<List<ProductModel>> getProductList(int categoryId) async {

    try {
      final resp = await dio.get('https://api.escuelajs.co/api/v1/products/?categoryId=$categoryId&limit=5&offset=0');
      final products = (resp.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
      return products; 

    } on DioException catch (e) {
        if (e.response?.statusCode != null &&
            e.response!.statusCode! >= 500 &&
            e.response!.statusCode! < 600) {
          throw ServerFailure();
        } else {
          throw NetworkFailure();
        }
    } catch (e) {
      throw UnexpectedError();
    }
  }
  
}
