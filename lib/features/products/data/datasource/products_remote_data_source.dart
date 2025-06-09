

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/models/category_model.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/models/product_model.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/entities.dart';

abstract class ProductsRemoteDataSource {
  Future<Either<Failure, List<CategoryModel>>> getCategoryList();
  Future<Either<Failure,List<Product>>> getProductList(int categoryId);
  Future<Either<Failure,ProductModel>> getProductInfo(int productId);
}

class ProductsAPIsSourceImpl implements ProductsRemoteDataSource {
  
  final Dio dio = Dio(); 

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoryList() async {
    try {

      final resp = await dio.get('https://api.escuelajs.co/api/v1/categories');
      final categories = (resp.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
      return Right(categories);

    } on DioException catch (e) {
      if (e.response?.statusCode != null &&
          e.response!.statusCode! >= 500 &&
          e.response!.statusCode! < 600) {
        return Left(ServerFailure());
      } else {
        return Left(NetworkFailure());
      }
    } catch (e) {
      return Left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure,ProductModel>> getProductInfo(int productId) async {
    try {

      final resp = await dio.get('https://api.escuelajs.co/api/v1/products/$productId');
      final product = ProductModel.fromJson(resp);
      return Right(product);  

    } on DioException catch (e) {
        if (e.response?.statusCode != null &&
            e.response!.statusCode! >= 500 &&
            e.response!.statusCode! < 600) {
          return Left(ServerFailure());
        } else {
          return Left(NetworkFailure());
        }
    } catch (e) {
      return Left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure,List<ProductModel>>> getProductList(int categoryId) async {
    try {
      final resp = await dio.get('https://api.escuelajs.co/api/v1/products/?categoryId=$categoryId&limit=5&offset=0');
      final products = (resp.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
      return Right(products);  

    } on DioException catch (e) {
        if (e.response?.statusCode != null &&
            e.response!.statusCode! >= 500 &&
            e.response!.statusCode! < 600) {
          return Left(ServerFailure());
        } else {
          return Left(NetworkFailure());
        }
    } catch (e) {
      return Left(UnexpectedError());
    }
  }
  
}
