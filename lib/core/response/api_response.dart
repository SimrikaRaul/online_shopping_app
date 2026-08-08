import 'package:firebase_setup/core/utils/status_utils.dart';


class ApiResponse<T> {
  final String message;
  final T? data;
  final StatusUtils type;

  ApiResponse({
    required this.message,
    required this.type,
    this.data,
  });
}