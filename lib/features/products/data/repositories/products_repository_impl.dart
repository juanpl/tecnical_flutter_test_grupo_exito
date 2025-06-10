import 'package:dartz/dartz.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_local_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_remote_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/category.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/product.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/shopping_cart.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/repository/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository{


  final ProductsLocalDataSource productsLocalDataSource;
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl({
    required this.productsLocalDataSource, 
    required this.productsRemoteDataSource
  });

  
  @override
  Future<Either<Failure, bool>> addProductToExpressShoppingCart(Product product) async{
    try {
      final bool resp = await productsLocalDataSource.addProductToExpressShoppingCart(product);
      return Right(resp);
    } on Failure catch (e)  {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> addProductToShoppingCart(Product product) async {
    try {
      final bool resp = await productsLocalDataSource.addProductToShoppingCart(product);
      return Right(resp);
    } on Failure catch (e)  {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> cleanExpressShoppingCart() async {
    try{
      final bool resp = await productsLocalDataSource.cleanExpressShoppingCart();
      return Right(resp);
    } on Failure catch (e)  {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> cleanShoppingCart() async {
    try{
      final bool resp = await productsLocalDataSource.cleanShoppingCart();
      return Right(resp);
    } on Failure catch (e)  {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategoryList() async{
    try {
      final List<Category> categories = await productsRemoteDataSource.getCategoryList();
      return Right(categories);
    } on Failure catch (e)  {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, ShoppingCart>> getExpressShoppingCartInfo() async{
    try {
      final ShoppingCart shoppingCart = await productsLocalDataSource.getExpressShoppingCartInfo();
      return Right(shoppingCart);
    } on Failure catch (e)  {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Product>> getProductInfo(int productId) async {
    try {
      final Product product = await productsRemoteDataSource.getProductInfo(productId);
      return Right(product);
    } on Failure catch (e)  {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductList(int categoryId) async {
    
    try {
      final List<Product> products = await productsRemoteDataSource.getProductList(categoryId);
      return Right(products); 
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, ShoppingCart>> getShoppingCartInfo() async {
    try {
      final ShoppingCart shoppingCart = await productsLocalDataSource.getShoppingCartInfo();
      return Right(shoppingCart);
    } on Failure catch (e)  {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> removeProductFromExpressShoppingCart(Product product) async {
    try {
      final bool resp = await productsLocalDataSource.removeProductFromExpressShoppingCart(product);
      return Right(resp);
    } on Failure catch (e)  {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> removeProductFromShoppingCart(Product product) async {
    try {
      final bool resp = await productsLocalDataSource.removeProductFromShoppingCart(product);
      return Right(resp);
    } on Failure catch (e)  {
      return Left(e);
    }
  }


}