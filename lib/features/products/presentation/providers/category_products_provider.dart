import 'package:flutter/material.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/product.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_product_list.dart';

class CategoryProductsProvider extends ChangeNotifier {
  
  final GetProductListUseCase _getProductListUseCase;
  final int categoryId;

  List<Product> products = [];
  bool isLoading = false;
  String? errorMessage;

  CategoryProductsProvider({
    required GetProductListUseCase getProductListUseCase, 
    required this.categoryId}
  ) : _getProductListUseCase = getProductListUseCase{
    this.getCategryProducts();
  }

  Future<void> getCategryProducts() async{
    isLoading = true;
    errorMessage = null;
    notifyListeners();

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

    isLoading = false;
    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return 'Error del servidor.';
    if (failure is NetworkFailure) return 'Sin conexión.';
    return 'Ocurrió un error inesperado.';
  }
  
}