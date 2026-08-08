import 'package:equatable/equatable.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/signup/model/signup_model.dart';
class SignUpState extends Equatable{
  
  final StatusUtils status;
  final SignUpModel? signupResponse;
  final String? message;

  SignUpState({
    this.status=StatusUtils.initial,
    this.signupResponse,
    this.message
  });
  
  SignUpState copyWith({
    StatusUtils? status,
    SignUpModel? loginResponse,
    String? message,
  }){
    return SignUpState(
      status: status?? this.status,
      signupResponse: loginResponse?? this.signupResponse,
      message: message,
    );
  }
  
 
  @override
  
  List<Object?> get props => [
    status,
    signupResponse,
    message,
  ];
}