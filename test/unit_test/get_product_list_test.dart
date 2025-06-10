
import 'package:flutter_test/flutter_test.dart';
import 'package:tecnical_flutter_test_grupo_exito/core/error/failures.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_local_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_remote_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/repositories/products_repository_impl.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_product_list.dart';

void main() {

  late GetProductListUseCase useCase;
  
  setUp((){
    final repository = ProductsRepositoryImpl(
      productsRemoteDataSource: ProductsAPIsSourceImpl(),
      productsLocalDataSource: ProductsSqliteDataSourceImpl.db, // si no lo usas aquí
    );
    useCase = GetProductListUseCase(repository: repository);
  });

  test('should return right result', () async{
    final result = await useCase(1);

      expect(result.isRight(), true);
      result.fold(
      (failure) {
        expect(failure, isA<UnexpectedError>());
      },
      (products) {
        expect(products, isNotEmpty);
        expect(products.first.name, 'Classic Heather Gray Hoodie');
      },
    );
  });


}