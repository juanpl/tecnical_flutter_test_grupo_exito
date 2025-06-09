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

  final int productId;
  final String name;
  final String image;
  final String category;
  final double price;
  final int quitity;

  ShoppingCartProduct({
    required this.productId, 
    required this.name, 
    required this.image, 
    required this.category, 
    required this.price, 
    required this.quitity
  });
  
}