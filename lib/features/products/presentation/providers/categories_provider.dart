import 'package:flutter/material.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/category.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_category_list.dart';

class CategoriesProvider extends ChangeNotifier {
  
  final GetCategoryListUseCase _getCategoryListUseCase;

  CategoriesProvider({required GetCategoryListUseCase getCategoryListUseCase}) : _getCategoryListUseCase = getCategoryListUseCase;

  List<Category> categories = [];

  Future<void> setCategoryItem() async {
    final result = await _getCategoryListUseCase();

    result.fold(
      (failure) {
        // puedes guardar el error en una variable o manejarlo aquí
        categories = [];
        notifyListeners();
      },
      (list) {
        categories = list;
        notifyListeners();
      },
    );
  }
}