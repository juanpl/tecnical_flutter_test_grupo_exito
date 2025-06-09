import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  
  ProductModel({
    required super.productId, 
    required super.name, 
    required super.description, 
    required super.image, 
    required super.category, 
    required super.price
  });
  
  factory ProductModel.fromJson(json) {
    return ProductModel(
      productId: json['id'], 
      name: json['name'], 
      description: json['description'], 
      image: json['images'].fisrt, 
      category: json['category']['name'], 
      price: json['price']
    );
  }

  factory ProductModel.fromEntity(Product product){
    return ProductModel(
      productId: product.productId, 
      name: product.name, 
      description: product.description, 
      image: product.image, 
      category: product.category, 
      price: product.price
    );
  }


}