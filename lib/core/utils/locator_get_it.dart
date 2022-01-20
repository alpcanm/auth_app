import 'package:auth_app/core/repositories/auth_repository.dart';
import 'package:auth_app/core/repositories/init_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton(() => InitRepository());
  getIt.registerLazySingleton(() => AuthRepository());
}
