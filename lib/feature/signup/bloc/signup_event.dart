import 'package:equatable/equatable.dart';

class SignUpEvent extends Equatable{

  @override
  List<Object?> get props => [];
}
class SignupButtonEvent extends SignUpEvent{
  final String name;
  final String password;
  final String emailAddress;
  final String confirmPassword;

  SignupButtonEvent({
    required this.name,
    required this.password,
    required this.confirmPassword,
    required this.emailAddress,
  });

  @override
  List<Object?> get props => [name, emailAddress,password,confirmPassword];
}