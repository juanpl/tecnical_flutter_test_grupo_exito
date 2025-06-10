import 'package:flutter/material.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/category.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_category_list.dart';

class CategoriesProvider extends ChangeNotifier {
  
  final GetCategoryListUseCase _getCategoryListUseCase;
  

  CategoriesProvider({required GetCategoryListUseCase getCategoryListUseCase}) : _getCategoryListUseCase = getCategoryListUseCase {
    this.getCategoryItems();
  }

  List<Category> categories =[];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getCategoryItems() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _getCategoryListUseCase();

    result.fold(
      (failure) {
        categories = [];
        errorMessage = _mapFailureToMessage(failure);
      },
      (list) {
        categories = list;
      },
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