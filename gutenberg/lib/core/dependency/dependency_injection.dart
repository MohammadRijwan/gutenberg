import 'package:get_it/get_it.dart';
import 'package:gutenberg/feature/book/data/app_repository.dart';

void setupDependencies() {
  GetIt.instance.registerSingleton<AppRepository>(AppRepository());
}
