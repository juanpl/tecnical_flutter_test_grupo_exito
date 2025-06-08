
import 'package:dartz/dartz.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/product.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/repository/products_repository.dart';

class GetProductInfoUseCase {
  
  final ProductsRepository repository;

  GetProductInfoUseCase({required this.repository});

  Future<Either<Failure, Product>> call(int productId){
    return repository.getProductInfo(productId);
  }
}
