
import 'package:dartz/dartz.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/product.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/repository/products_repository.dart';

class GetProductListUseCase {
  
  final ProductsRepository repository;

  GetProductListUseCase({required this.repository});

  Future<Either<Failure, List<Product>>> call(int categoryId){
    return repository.getProductList(categoryId);
  }

}