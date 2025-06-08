
import 'package:dartz/dartz.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/shopping_cart.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/repository/products_repository.dart';

class GetExpressShoppingCartInfoUseCase {
  
  final ProductsRepository repository;

  GetExpressShoppingCartInfoUseCase({required this.repository});

  Future<Either<Failure, ShoppingCart>> call(){
    return repository.getExpressShoppingCartInfo();
  }

}