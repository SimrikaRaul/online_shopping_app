import 'package:firebase_setup/core/utils/cloudinary_service.dart';
import 'package:firebase_setup/feature/login/bloc/login_bloc.dart';
import 'package:firebase_setup/feature/login/service/login_service.dart';
import 'package:firebase_setup/feature/login/service/login_service_impl.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_bloc.dart';
import 'package:firebase_setup/feature/product/service/add_product_service.dart';
import 'package:firebase_setup/feature/product/service/add_product_service_impl.dart';
import 'package:firebase_setup/feature/search/bloc/search_bloc.dart';
import 'package:firebase_setup/feature/signup/bloc/signup_bloc.dart';
import 'package:firebase_setup/feature/signup/service/signup_service.dart';
import 'package:firebase_setup/feature/signup/service/signup_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  //core
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // Services
  getIt.registerLazySingleton<SignupService>(() => SignupServiceImpl());
  getIt.registerLazySingleton<LoginService>(() => LoginServiceImpl());
  getIt.registerLazySingleton<AddProductService>(() => AddProductServiceImpl());
  getIt.registerLazySingleton<CloudinaryService>(() => CloudinaryService());
  // Bloc
  getIt.registerFactory<SignUpBloc>(() => SignUpBloc(getIt()));
  getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt()));
  getIt.registerFactory<AddProductBloc>(() => AddProductBloc(getIt(), getIt()));
  getIt.registerFactory<SearchBloc>(
    () => SearchBloc(getIt<AddProductService>()),
  );
}
