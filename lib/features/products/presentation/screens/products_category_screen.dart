import 'package:flutter/material.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/widgets/custom_app_bar.dart';

class ProductsCategoryScreen extends StatelessWidget {
  
  static const String name = 'products_category_screen';

  final int? categoryId;

  const ProductsCategoryScreen({super.key, this.categoryId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Producto'),
      body: Center(
        child: Text('products_category_screen $categoryId')
      ),
    );
  }
}