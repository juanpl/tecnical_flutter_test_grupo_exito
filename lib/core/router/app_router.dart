import 'package:go_router/go_router.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_product_list.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/screens/categories_screen.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/screens/category_products_screen.dart';
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
      name: CategoryProductsScreen.name,
      builder: (context, state) {
        final String? categoryId = state.uri.queryParameters['categoryId'];
        final String? name = state.uri.queryParameters['categoryName'];
        final int? id = int.tryParse(categoryId ?? '');
        return CategoryProductsScreen(
          addProductToShoppingCartUseCase: addProductToShoppingCartUseCase,
          categoryName: name,
          categoryId: id,
          getProductListUseCase: getProductListUseCase,
          getShoppingCartInfoUseCase: getShoppingCartInfoUseCase,
        );
      }, 
    ),

  ]
);