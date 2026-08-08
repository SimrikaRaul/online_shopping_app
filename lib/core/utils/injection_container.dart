import 'package:firebase_setup/feature/login/bloc/login_bloc.dart';
import 'package:firebase_setup/feature/login/service/login_service.dart';
import 'package:firebase_setup/feature/login/service/login_service_impl.dart';
import 'package:firebase_setup/feature/signup/bloc/signup_bloc.dart';
import 'package:firebase_setup/feature/signup/service/signup_service.dart';
import 'package:firebase_setup/feature/signup/service/signup_service_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  getIt.registerLazySingleton<SignupService>(() => SignupServiceImpl());
  getIt.registerLazySingleton<LoginService>(() => LoginServiceImpl());
  // Bloc
  getIt.registerFactory<SignUpBloc>(() => SignUpBloc(getIt()));
   getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt()));
}