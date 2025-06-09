import 'package:go_router/go_router.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/screens/categories_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/categories',
  routes: [

    GoRoute(
      path: '/categories',
      name: CategoriesScreen.name,
      builder: (context, state) => CategoriesScreen(),
    )

  ]
);