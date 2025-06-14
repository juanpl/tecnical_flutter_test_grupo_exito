
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

  Future<ShoppingCart> getShoppingCartInfo();
  Future<ShoppingCart> getExpressShoppingCartInfo();
  Future<bool> addProductToShoppingCart(Product product); 
  Future<bool> removeProductFromShoppingCart(Product product);
  Future<bool> addProductToExpressShoppingCart(Product product); 
  Future<bool> removeProductFromExpressShoppingCart(Product product);
  Future<bool> cleanShoppingCart();
  Future<bool> cleanExpressShoppingCart();

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
            price INTEGER,
            quantity INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE ShoppingExpressCart(
            id INTEGER PRIMARY KEY,
            productId INTEGER,
            name TEXT,
            image TEXT,
            category TEXT,
            price INTEGER,
            quantity INTEGER
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
        quantity: 1
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
      final idProd = await db!.update(tableName, {'quantity': result}, where: 'productId = ?', whereArgs: [productId]);
      return idProd;

    } else {

      final db = await database;
      final deleteCount = await db!.delete(tableName, where: 'productId = ?', whereArgs: [productId]);
      return deleteCount;
    }

  }



  @override
  Future<bool> addProductToExpressShoppingCart(Product product) async{
    final  existingProduct = await checkExistingProduct(product.productId, 'ShoppingExpressCart');

    if(existingProduct == true){

      ShoppingCartProduct shoppingCartProduct = await loadProductDatabase(product.productId, 'ShoppingExpressCart');
      int updValue = await productUpdate(product.productId, 'ShoppingExpressCart', shoppingCartProduct.quantity, 1);
      if(updValue>0){
        return true;
      } else {
        throw SaveLocalDataError();
      }

    } else {
        final userId = await addNewProductToDataBase(product, 'ShoppingExpressCart');
        if(userId>0){
          return true;
        }
        else {
          throw SaveLocalDataError();
        }
    }

  }


  @override
  Future<bool> addProductToShoppingCart(Product product) async{
    final  existingProduct = await checkExistingProduct(product.productId, 'ShoppingCart');

    if(existingProduct == true){

      ShoppingCartProduct shoppingCartProduct = await loadProductDatabase(product.productId, 'ShoppingCart');
      int updValue = await productUpdate(product.productId, 'ShoppingCart', shoppingCartProduct.quantity, 1);
      if(updValue>0){
        return true;
      } else {
        throw SaveLocalDataError();
      }

    } else {
        final userId = await addNewProductToDataBase(product, 'ShoppingCart');
        if(userId>0){
          return true;
        }
        else {
          return throw SaveLocalDataError();
        }
    }
  }

  @override
  Future<bool> cleanExpressShoppingCart() async{
    final db = await database;
    int deletedCount = await db!.delete('ShoppingExpressCart');
    if(deletedCount>0){
      return true;
    } else {
      throw DeleteLocalDataError();
    }
  }

  @override
  Future<bool> cleanShoppingCart() async{
    final db = await database;
    int deletedCount = await db!.delete('ShoppingCart');
    if(deletedCount>0){
      return true;
    } else {
      return throw DeleteLocalDataError();
    }
  }

  @override
  Future<ShoppingCart> getExpressShoppingCartInfo() async{
    final db = await database;
    final results = await db!.query('ShoppingExpressCart');
    final List<ShoppingCartProdutModel> products = results.map((json) => ShoppingCartProdutModel.fromJson(json)).toList();

    double totalValue = 0;

    for(var product in products){
      var totalProdutValue = product.price*product.quantity;
      totalValue = totalValue+totalProdutValue;
    }

    final ShoppingCart shoppingCart = ShoppingCart(
      productList: products, 
      totalShoppingCartPrice: totalValue
    );
 
    if(results!=null){
      return shoppingCart;
    } else {
      throw DeleteLocalDataError();
    }
  }

  @override
  Future<ShoppingCart> getShoppingCartInfo() async{
    final db = await database;
    final results = await db!.query('ShoppingCart');
    final List<ShoppingCartProdutModel> products = results.map((json) => ShoppingCartProdutModel.fromJson(json)).toList();

    double totalValue = 0;

    for(var product in products){
      var totalProdutValue = product.price*product.quantity;
      totalValue = totalValue+totalProdutValue;
    }

    final ShoppingCart shoppingCart = ShoppingCart(
      productList: products, 
      totalShoppingCartPrice: totalValue
    );
 
    if(results!=null){
      return shoppingCart;
    } else {
      throw DeleteLocalDataError();
    }
  }

  @override
  Future<bool> removeProductFromExpressShoppingCart(Product product) async{
    final  existingProduct = await checkExistingProduct(product.productId, 'ShoppingExpressCart');

    if(existingProduct == true){

      ShoppingCartProduct shoppingCartProduct = await loadProductDatabase(product.productId, 'ShoppingExpressCart');
      int updValue = await productUpdate(product.productId, 'ShoppingExpressCart', shoppingCartProduct.quantity, -1);
      if(updValue>0){
        return true;
      } else {
        throw SaveLocalDataError();
      }

    } else {
        final userId = await addNewProductToDataBase(product, 'ShoppingExpressCart');
        if(userId>0){
          return true;
        }
        else {
          throw SaveLocalDataError();
        }
    }
  }

  @override
  Future<bool> removeProductFromShoppingCart(Product product) async{
    final  existingProduct = await checkExistingProduct(product.productId, 'ShoppingCart');

    if(existingProduct == true){

      ShoppingCartProduct shoppingCartProduct = await loadProductDatabase(product.productId, 'ShoppingCart');
      int updValue = await productUpdate(product.productId, 'ShoppingCart', shoppingCartProduct.quantity, -1);
      if(updValue>0){
        return true;
      } else {
        throw SaveLocalDataError();
      }

    } else {
        final userId = await addNewProductToDataBase(product, 'ShoppingCart');
        if(userId>0){
          return true;
        }
        else {
          throw SaveLocalDataError();
        }
    }
  }

}

