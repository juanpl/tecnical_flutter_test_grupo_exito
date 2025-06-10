import 'package:go_router/go_router.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/screens/categories_screen.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/screens/products_category_screen.dart';
import 'package:tecnical_flutter_test_grupo_exito/inyection.dart';

final appRouter = GoRouter(
  initialLocation: '/categories',
  routes: [

    GoRoute(
      path: '/categories',
      name: CategoriesScreen.name,
      builder: (context, state) => CategoriesScreen(getCategoryListUseCase: getCategoryListUseCase),
    ),

    GoRoute(
      path: '/products_category',
      name: ProductsCategoryScreen.name,
      builder: (context, state) {
        final String? categoryId = state.uri.queryParameters['categoryId'];
        final int? id = int.tryParse(categoryId ?? '');
        return ProductsCategoryScreen(categoryId: id);
      }, 
    ),

  ]
);