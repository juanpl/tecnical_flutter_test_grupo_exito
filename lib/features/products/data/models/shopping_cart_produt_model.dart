import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/shopping_cart.dart';

class ShoppingCartProdutModel extends ShoppingCartProduct {

  ShoppingCartProdutModel({
    required super.productId, 
    required super.name, 
    required super.image, 
    required super.category, 
    required super.price, 
    required super.quitity
  });

  factory ShoppingCartProdutModel.fromEntity(ShoppingCartProduct shoppingCartProduct){
    return ShoppingCartProdutModel(
      productId: shoppingCartProduct.productId, 
      name: shoppingCartProduct.name, 
      image: shoppingCartProduct.image, 
      category: shoppingCartProduct.category, 
      price: shoppingCartProduct.price, 
      quitity: shoppingCartProduct.quitity
    );
  }

  factory ShoppingCartProdutModel.fromJson(json) {
    return ShoppingCartProdutModel(
      productId: json['productId'],
      category: json['category'],
      image: json['image'],
      name: json['name'],
      price: json['price'],
      quitity: json['quitity']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId' : productId,
      'category' : category,
      'image' : image,
      'name': name,
      'price': price,
      'quitity': quitity
    };
  }
  
}