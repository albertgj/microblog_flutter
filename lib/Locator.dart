import 'package:get_it/get_it.dart';
import 'package:microblog/service/Api.dart';
import 'package:microblog/service/AuthenticationService.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => Api());
  GetIt.I.registerLazySingleton(() => AuthenticationService());
}
