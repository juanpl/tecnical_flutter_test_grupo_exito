
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/category.dart';


class CategoryModel extends Category {
  
  CategoryModel({
    required super.categoryId, 
    required super.name, 
    required super.image, 
  });

  factory CategoryModel.fromJson(json) {
    return CategoryModel(
      categoryId: json['id'], 
      name: json['name'], 
      image: json['image'], 
    );
  }


  factory CategoryModel.fromEntity(Category category){
    return CategoryModel(
      categoryId: category.categoryId, 
      name: category.name, 
      image: category.image
    );
  }
  
}