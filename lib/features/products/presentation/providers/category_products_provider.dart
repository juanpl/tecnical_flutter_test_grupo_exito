import 'package:flutter/material.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/product.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/shopping_cart.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/add_product_to_express_shopping_cart.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/add_product_to_shopping_cart.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_product_list.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_shopping_cart_info.dart';

class CategoryProductsProvider extends ChangeNotifier {
  
  final GetProductListUseCase _getProductListUseCase;
  final AddProductToShoppingCartUseCase _addProductToShoppingCartUseCase;
  final GetShoppingCartInfoUseCase _getShoppingCartInfoUseCase;

  CategoryProductsProvider({
    required AddProductToShoppingCartUseCase addProductToShoppingCartUseCase,
    required GetProductListUseCase getProductListUseCase, 
    required GetShoppingCartInfoUseCase getShoppingCartInfoUseCase,
    required this.categoryId}
  ) : _getProductListUseCase = getProductListUseCase,
      _addProductToShoppingCartUseCase = addProductToShoppingCartUseCase,
      _getShoppingCartInfoUseCase = getShoppingCartInfoUseCase
  {
    this.initScreen();
  }

  final int categoryId;
  List<Product> products = [];
  bool isLoading = false;
  String? errorMessage;
  ShoppingCart? shoppingCart;

  Future<void> initScreen() async{
    isLoading = true;
    notifyListeners();

    await getCategryProducts();
    await loadShoppingCartInf();

    isLoading = false;
    notifyListeners();
  }


  Future<void> loadShoppingCartInf() async{
    final result = await _getShoppingCartInfoUseCase();

    result.fold(
      (failure){
        products = [];
        errorMessage = _mapFailureToMessage(failure);
      },
      (result){
        shoppingCart = result;
        
      }
    );
  }

  Future<void> addProductToShoppingCart(Product product) async{
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _addProductToShoppingCartUseCase(product);

    result.fold(
      (failure){
        products = [];
        errorMessage = _mapFailureToMessage(failure);
      },
      (list) async{
        await loadShoppingCartInf();

      }
    );

    isLoading = false;
    notifyListeners();

  }

  Future<void> getCategryProducts() async{
    final result = await _getProductListUseCase(categoryId);

    result.fold(
      (failure){
        products = [];
        errorMessage = _mapFailureToMessage(failure);
      },
      (list){
        products = list;
      }
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return 'Error del servidor.';
    if (failure is NetworkFailure) return 'Sin conexión.';
    if (failure is SaveLocalDataError) return 'Error de guardado en la base de datos';
    
    return 'Ocurrió un error inesperado.';
  }
  



}