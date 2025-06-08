import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/product.dart';

class ShoppingCart {
  
  final List<ShoppingCartProduct> productList;
  final double totalShoppingCartPrice;

  ShoppingCart({
    required this.productList,
    required this.totalShoppingCartPrice
  });

}

class ShoppingCartProduct {

  final Product product;
  final int quitity;
  final double totalProductPrice;

  ShoppingCartProduct({
    required this.product, 
    required this.quitity, 
    required this.totalProductPrice
  }); 

}