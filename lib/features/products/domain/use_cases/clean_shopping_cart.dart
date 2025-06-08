import 'package:dartz/dartz.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/repository/products_repository.dart';

class CleanShoppingCartUseCase {

  final ProductsRepository repository;

  CleanShoppingCartUseCase({required this.repository});

  Future<Either<Failure, bool>> call(){
    return repository.cleanShoppingCart();
  }
  
}