import 'package:flutter_test/flutter_test.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_local_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_remote_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/repositories/products_repository_impl.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_category_list.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/presentation/screens/categories_screen.dart';

void main() {
  late GetCategoryListUseCase useCase;

  setUp(() {
    final repository = ProductsRepositoryImpl(
      productsRemoteDataSource: ProductsAPIsSourceImpl(),
      productsLocalDataSource: ProductsSqliteDataSourceImpl.db, // si no lo usas aquí
    );
    useCase = GetCategoryListUseCase(repository: repository);
  });

  test('should return list of categories from API', () async {
    final result = await useCase();

    expect(result.isRight(), true);

    result.fold(
      (_) => fail('Expected list of categories, got Failure.'),
      (categories) {
        expect(categories, isNotEmpty);
        expect(categories.first.name, isNotEmpty); 
        expect(categories.first.name, 'Clothes');
        expect(categories.first.categoryId, 1);
        expect(categories.length, 11);
      },
    );
  });
}