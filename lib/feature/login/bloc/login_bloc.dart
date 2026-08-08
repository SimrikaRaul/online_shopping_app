import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/login/bloc/login_event.dart';
import 'package:firebase_setup/feature/login/bloc/login_state.dart';
import 'package:firebase_setup/feature/login/model/login_model.dart';
import 'package:firebase_setup/feature/login/service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;

  LoginBloc(this.loginService) : super(LoginState()) {
    on<LoginButtonEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUtils.loading, message: null));

      final response = await loginService.login(
        LoginModel(email: event.email.trim(), password: event.password.trim()),
      );

      emit(state.copyWith(status: response.type, message: response.message));
    });
  }
}