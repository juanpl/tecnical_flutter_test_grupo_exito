
import 'package:dartz/dartz.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/entities.dart';


abstract class ProductsRepository {

  Future<Either<Failure, List<Category>>> getCategoryList();
  Future<Either<Failure, List<Product>>> getProductList(int categoryId);
  Future<Either<Failure, Product>> getProductInfo(int productId);
  Future<Either<Failure, ShoppingCart>> getShoppingCartInfo();
  Future<Either<Failure, ShoppingCart>> getExpressShoppingCartInfo();
  Future<Either<Failure, bool>> addProductToShoppingCart(int productId); 
  Future<Either<Failure, bool>> removeProductFromShoppingCart(int productId);
  Future<Either<Failure, bool>> addProductToExpressShoppingCart(int productId); 
  Future<Either<Failure, bool>> removeProductFromExpressShoppingCart(int productId);
  Future<Either<Failure, bool>> cleanShoppingCart();
  Future<Either<Failure, bool>> cleanExpressShoppingCart();

}