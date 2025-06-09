
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/models/shopping_cart_produt_model.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/entities.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_product_info.dart';

abstract class ProductsLocalDataSource {

  Future<Either<Failure, ShoppingCart>> getShoppingCartInfo();
  Future<Either<Failure, ShoppingCart>> getExpressShoppingCartInfo();
  Future<Either<Failure, bool>> addProductToShoppingCart(Product product); 
  Future<Either<Failure, bool>> removeProductFromShoppingCart(Product product);
  Future<Either<Failure, bool>> addProductToExpressShoppingCart(Product product); 
  Future<Either<Failure, bool>> removeProductFromExpressShoppingCart(Product product);
  Future<Either<Failure, bool>> cleanShoppingCart();
  Future<Either<Failure, bool>> cleanExpressShoppingCart();

}

class ProductsSqliteDataSourceImpl extends ProductsLocalDataSource {

  static Database? _database;
  static final ProductsSqliteDataSourceImpl db = ProductsSqliteDataSourceImpl._();
  ProductsSqliteDataSourceImpl._();

  Future<Database?> get database async{
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async{

    //Path donde se almacena la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'UsersDB.db');

    //created data base
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version) async{

        await db.execute('''
          CREATE TABLE ShoppingCart(
            id INTEGER PRIMARY KEY,
            productId INTEGER,
            name TEXT,
            image TEXT,
            category TEXT,
            price REAL,
            quntity INTEGER,
          )
        ''');

        await db.execute('''
          CREATE TABLE ShoppingExpressCart(
            id INTEGER PRIMARY KEY,
            productId INTEGER,
            name TEXT,
            image TEXT,
            category TEXT,
            price REAL,
            quntity INTEGER,
          )
        ''');
      
      }
    );

  }

  Future<bool> checkExistingProduct(int productId, String tableName) async {
    final db = await database;
    final res = await db!.query(tableName, where: 'productId = ?', whereArgs: [productId]);

    return res.isNotEmpty
            ? true
            : false;
  }

  Future<int> addNewProductToDataBase(Product product, String tableName) async{
      
      ShoppingCartProduct newProduct = ShoppingCartProduct(
        productId: product.productId, 
        name: product.name, 
        image: product.image, 
        category: product.category, 
        price: product.price, 
        quitity: 1
      );

      ShoppingCartProdutModel newProductModel = ShoppingCartProdutModel.fromEntity(newProduct); 

      final db = await database;
      final userId = await db!.insert(tableName, newProductModel.toJson());

      return userId;
  }

  Future<ShoppingCartProduct> loadProductDatabase(int productId, String tableName) async{
    final db = await database;
    final res = await db!.query(tableName, where: 'productId = ?', whereArgs: [productId]);
    final ShoppingCartProdutModel product = ShoppingCartProdutModel.fromJson(res.first);

    return product; 
  }

  Future<int> productUpdate(int productId, String tableName, int actuallQuantity, int valueToAdd) async{
    final result = actuallQuantity + valueToAdd;

    if(result > 0){

      final db = await database;
      final idProd = await db!.update(tableName, {'quntity': result}, where: 'productId = ?', whereArgs: [productId]);
      return idProd;

    } else {

      final db = await database;
      final deleteCount = await db!.delete(tableName, where: 'productId = ?', whereArgs: [productId]);
      return deleteCount;
    }

  }



  @override
  Future<Either<Failure, bool>> addProductToExpressShoppingCart(Product product) async{
    final  existingProduct = await checkExistingProduct(product.productId, 'ShoppingExpressCart');

    if(existingProduct == true){

      ShoppingCartProduct shoppingCartProduct = await loadProductDatabase(product.productId, 'ShoppingExpressCart');
      int updValue = await productUpdate(product.productId, 'ShoppingExpressCart', shoppingCartProduct.quitity, 1);
      if(updValue>0){
        return Right(true);
      } else {
        return Left(SaveLocalDataError());
      }

    } else {
        final userId = await addNewProductToDataBase(product, 'ShoppingExpressCart');
        if(userId>0){
          return Right(true);
        }
        else {
          return Left(SaveLocalDataError());
        }
    }
  }


  @override
  Future<Either<Failure, bool>> addProductToShoppingCart(Product product) async{
    final  existingProduct = await checkExistingProduct(product.productId, 'ShoppingCart');

    if(existingProduct == true){

      ShoppingCartProduct shoppingCartProduct = await loadProductDatabase(product.productId, 'ShoppingCart');
      int updValue = await productUpdate(product.productId, 'ShoppingCart', shoppingCartProduct.quitity, 1);
      if(updValue>0){
        return Right(true);
      } else {
        return Left(SaveLocalDataError());
      }

    } else {
        final userId = await addNewProductToDataBase(product, 'ShoppingCart');
        if(userId>0){
          return Right(true);
        }
        else {
          return Left(SaveLocalDataError());
        }
    }
  }

  @override
  Future<Either<Failure, bool>> cleanExpressShoppingCart() async{
    final db = await database;
    int deletedCount = await db!.delete('ShoppingExpressCart');
    if(deletedCount>0){
      return Right(true);
    } else {
      return Left(DeleteLocalDataError());
    }
  }

  @override
  Future<Either<Failure, bool>> cleanShoppingCart() async{
    final db = await database;
    int deletedCount = await db!.delete('ShoppingCart');
    if(deletedCount>0){
      return Right(true);
    } else {
      return Left(DeleteLocalDataError());
    }
  }

  @override
  Future<Either<Failure, ShoppingCart>> getExpressShoppingCartInfo() async{
    final db = await database;
    final results = await db!.query('ShoppingExpressCart');
    final List<ShoppingCartProdutModel> products = results.map((json) => ShoppingCartProdutModel.fromJson(json)).toList();

    double totalValue = 0;

    for(var product in products){
      var totalProdutValue = product.price*product.quitity;
      totalValue = totalValue+totalProdutValue;
    }

    final ShoppingCart shoppingCart = ShoppingCart(
      productList: products, 
      totalShoppingCartPrice: totalValue
    );
 
    if(results!=null){
      return Right(shoppingCart);
    } else {
      return Left(DeleteLocalDataError());
    }
  }

  @override
  Future<Either<Failure, ShoppingCart>> getShoppingCartInfo() async{
    final db = await database;
    final results = await db!.query('ShoppingCart');
    final List<ShoppingCartProdutModel> products = results.map((json) => ShoppingCartProdutModel.fromJson(json)).toList();

    double totalValue = 0;

    for(var product in products){
      var totalProdutValue = product.price*product.quitity;
      totalValue = totalValue+totalProdutValue;
    }

    final ShoppingCart shoppingCart = ShoppingCart(
      productList: products, 
      totalShoppingCartPrice: totalValue
    );
 
    if(results!=null){
      return Right(shoppingCart);
    } else {
      return Left(DeleteLocalDataError());
    }
  }

  @override
  Future<Either<Failure, bool>> removeProductFromExpressShoppingCart(Product product) async{
    final  existingProduct = await checkExistingProduct(product.productId, 'ShoppingExpressCart');

    if(existingProduct == true){

      ShoppingCartProduct shoppingCartProduct = await loadProductDatabase(product.productId, 'ShoppingExpressCart');
      int updValue = await productUpdate(product.productId, 'ShoppingExpressCart', shoppingCartProduct.quitity, -1);
      if(updValue>0){
        return Right(true);
      } else {
        return Left(SaveLocalDataError());
      }

    } else {
        final userId = await addNewProductToDataBase(product, 'ShoppingExpressCart');
        if(userId>0){
          return Right(true);
        }
        else {
          return Left(SaveLocalDataError());
        }
    }
  }

  @override
  Future<Either<Failure, bool>> removeProductFromShoppingCart(Product product) async{
    final  existingProduct = await checkExistingProduct(product.productId, 'ShoppingCart');

    if(existingProduct == true){

      ShoppingCartProduct shoppingCartProduct = await loadProductDatabase(product.productId, 'ShoppingCart');
      int updValue = await productUpdate(product.productId, 'ShoppingCart', shoppingCartProduct.quitity, -1);
      if(updValue>0){
        return Right(true);
      } else {
        return Left(SaveLocalDataError());
      }

    } else {
        final userId = await addNewProductToDataBase(product, 'ShoppingCart');
        if(userId>0){
          return Right(true);
        }
        else {
          return Left(SaveLocalDataError());
        }
    }
  }

}

