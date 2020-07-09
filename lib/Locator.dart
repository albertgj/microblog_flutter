import 'package:get_it/get_it.dart';
import 'package:microblog/service/Api.dart';
import 'package:microblog/service/AuthenticationService.dart';
import 'package:microblog/viewmodel/CommentModel.dart';
import 'package:microblog/viewmodel/HomeModel.dart';
import 'package:microblog/viewmodel/LoginModel.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => LoginModel());
  GetIt.I.registerLazySingleton(() => Api());
  GetIt.I.registerLazySingleton(() => AuthenticationService());
  GetIt.I.registerLazySingleton(() => HomeModel());
  GetIt.I.registerLazySingleton(() => CommentModel());
}
