import 'package:dartz/dartz.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/product.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/repository/products_repository.dart';

class RemoveProductFromExpressShoppingCartUseCase {
  
  final ProductsRepository repository;

  RemoveProductFromExpressShoppingCartUseCase({required this.repository});

  Future<Either<Failure, bool>> call(Product product){
    return repository.removeProductFromExpressShoppingCart(product);
  }
}