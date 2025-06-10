import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_local_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_remote_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/repositories/products_repository_impl.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/category.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_category_list.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/providers/categories_provider.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/screens/products_category_screen.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/widgets/category_card_widget.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/widgets/custom_app_bar.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CategoriesScreen extends StatelessWidget {

  static const String name = 'categories_screen';
  final GetCategoryListUseCase getCategoryListUseCase;

  const CategoriesScreen({required this.getCategoryListUseCase});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoriesProvider(getCategoryListUseCase: getCategoryListUseCase),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Categorias'),
        body: Categories(),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final categoriesProvider = Provider.of<CategoriesProvider>(context);

    if(categoriesProvider.isLoading == true){
      return LoadingWidget();
    }

    else{
      return Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: categoriesProvider.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3/4,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                context.pushNamed(
                  ProductsCategoryScreen.name,
                  queryParameters: {
                    'categoryId': categoriesProvider.categories[index].categoryId.toString()
                  }
                );

              },
              child: CategoryCard(category: categoriesProvider.categories[index])
            );
          },
        ),
      );
    }
    

      
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                category.image,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}





