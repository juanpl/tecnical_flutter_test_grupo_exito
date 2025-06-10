import 'package:flutter/material.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/router/app_router.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_local_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_remote_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/repositories/products_repository_impl.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_category_list.dart';
import 'package:tecnical_flutter_test_grupo_exito/inyection.dart';

void main() {

  configureDependencies();
  runApp( MyApp(getCategoryListUseCase: getCategoryListUseCase));
}

class MyApp extends StatelessWidget {

  final GetCategoryListUseCase getCategoryListUseCase;
  const MyApp({required this.getCategoryListUseCase, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

