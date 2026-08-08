import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginButtonEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}