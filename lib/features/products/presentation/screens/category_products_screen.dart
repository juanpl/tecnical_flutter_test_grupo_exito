import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_product_list.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/providers/category_products_provider.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/widgets/custom_app_bar.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/widgets/loading_widget.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/widgets/products_category_card_widget.dart';

class CategoryProductsScreen extends StatelessWidget {
  
  static const String name = 'category_products_screen';
  final GetProductListUseCase getProductListUseCase;
  final int? categoryId;
  final String? categoryName;


  const CategoryProductsScreen({
    super.key,
    this.categoryName, 
    this.categoryId, 
    required this.getProductListUseCase
  });


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryProductsProvider(
        categoryId: categoryId!,
        getProductListUseCase: getProductListUseCase
      ),
      child: Scaffold(
        appBar: CustomAppBar(title: categoryName!),
        body: ScreenWidget(categoryId: categoryId),
      ),
    );
  }
}

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({
    super.key,
    required this.categoryId,
  });

  final int? categoryId;

  @override
  Widget build(BuildContext context) {

    final categoryProductsProvider = Provider.of<CategoryProductsProvider>(context);

    if(categoryProductsProvider.isLoading == true){
      return LoadingWidget();
    }
    else{
      return Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: categoryProductsProvider.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3/4,
          ),
          itemBuilder: (context, index) {
            return ProductsCategoryCardWidget(product: categoryProductsProvider.products[index]);
          },
        ),
      );      
    }

  }
}