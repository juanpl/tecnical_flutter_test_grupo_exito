

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/models/category_model.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/entities.dart';

abstract class ProductsRemoteDataSource {

  Future<Either<Failure, List<CategoryModel>>> getCategoryList();
  Future<List<Product>> getProductList(int categoryId);
  Future<Product> getProductInfo(int productId);

}


class ProdcutsAPIsSourceImpl implements ProductsRemoteDataSource {
  
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
  Future<Product> getProductInfo(int productId) {
    // TODO: implement getProductInfo
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductList(int categoryId) {
    // TODO: implement getProductList
    throw UnimplementedError();
  }
  
}
