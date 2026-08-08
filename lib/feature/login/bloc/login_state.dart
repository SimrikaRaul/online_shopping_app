import 'package:equatable/equatable.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';

class LoginState extends Equatable {
  final StatusUtils status;
  final String? message;

  LoginState({this.status = StatusUtils.initial, this.message});

  LoginState copyWith({StatusUtils? status, String? message}) {
    return LoginState(
      status: status ?? this.status,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}