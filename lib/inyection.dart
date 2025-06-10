
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_local_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/datasource/products_remote_data_source.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/data/repositories/products_repository_impl.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/repository/products_repository.dart';
import 'package:tecnical_flutter_test_grupo_exito/features/products/domain/use_cases/get_category_list.dart';

late final ProductsRepository productsRepository;
late final GetCategoryListUseCase getCategoryListUseCase;

void configureDependencies() {
  productsRepository = ProductsRepositoryImpl(
    productsLocalDataSource: ProductsSqliteDataSourceImpl.db,
    productsRemoteDataSource: ProductsAPIsSourceImpl(),
  );

  getCategoryListUseCase = GetCategoryListUseCase(repository: productsRepository);
}