import 'package:equatable/equatable.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';

class AddProductState extends Equatable {
  final StatusUtils status;
  final String? message;

  AddProductState({this.status = StatusUtils.initial, this.message});

  AddProductState copyWith({StatusUtils? status, String? message}) {
    return AddProductState(
      status: status ?? this.status,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}