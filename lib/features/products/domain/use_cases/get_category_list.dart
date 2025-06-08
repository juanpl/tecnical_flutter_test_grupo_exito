
import 'package:dartz/dartz.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/entities/category.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/repository/products_repository.dart';

class GetCategoryListUseCase {
  
  final ProductsRepository repository;

  GetCategoryListUseCase({required this.repository});

  Future<Either<Failure, List<Category>>> call(){
    return repository.getCategoryList();
  }
}