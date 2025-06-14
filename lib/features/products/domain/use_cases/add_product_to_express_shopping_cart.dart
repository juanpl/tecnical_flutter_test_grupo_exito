import 'package:dartz/dartz.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/product.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/repository/products_repository.dart';

class AddProductToExpressShoppingCartUseCase {
  
  final ProductsRepository repository;

  AddProductToExpressShoppingCartUseCase({required this.repository});

  Future<Either<Failure, bool>> call(Product product){
    return repository.addProductToExpressShoppingCart(product);
  } 

}