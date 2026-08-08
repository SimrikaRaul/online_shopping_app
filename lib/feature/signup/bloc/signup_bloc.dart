
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/signup/bloc/signup_event.dart';
import 'package:firebase_setup/feature/signup/bloc/signup_state.dart';
import 'package:firebase_setup/feature/signup/model/signup_model.dart';
import 'package:firebase_setup/feature/signup/service/signup_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState> {
  final SignupService signupService;

  SignUpBloc(this.signupService) : super(SignUpState()) {
    on<SignupButtonEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: StatusUtils.loading,
          message: null));
     
      final response = await signupService.signup(
        SignUpModel(
          name: event.name.trim(),
          password: event.password.trim(),
          email: event.emailAddress.trim(),
          confirmPassword: event.confirmPassword.trim(),
        ),
      );

      emit(
        state.copyWith(
          status: response.type, 
          message: response.message));
    });
  }
}
