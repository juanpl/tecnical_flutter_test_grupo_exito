

import 'package:flutter_test/flutter_test.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_local_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_remote_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/repositories/products_repository_impl.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/entities.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/add_product_to_shopping_cart.dart';
import 'package:sqflite/sqflite.dart';

void main(){

  late AddProductToShoppingCartUseCase useCase;
  late Database db;

  setUp(() async {

    db = await openDatabase(
      inMemoryDatabasePath, 
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ShoppingCart(
            id INTEGER PRIMARY KEY,
            productId INTEGER,
            name TEXT,
            image TEXT,
            category TEXT,
            price INTEGER,
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
            price INTEGER,
            quntity INTEGER,
          )
        ''');
      },
    );

    tearDown(() async {
      await db.close();
    });


    final repository = ProductsRepositoryImpl(
        productsRemoteDataSource: ProductsAPIsSourceImpl(),
        productsLocalDataSource: ProductsSqliteDataSourceImpl.db, // si no lo usas aquí
      );
      useCase = AddProductToShoppingCartUseCase(repository: repository);
    });

    test('should return list of categories from API', () async {
      
      Product exampleProduct = Product(
        productId: 1, 
        name: 'Example', 
        description: 'Example description', 
        image:'https://i.imgur.com/QkIa5tT.jpeg', 
        category: 'Example', 
        price: 99
      );

      final result = await useCase(exampleProduct);

      expect(result.isLeft(), true);

    });

}