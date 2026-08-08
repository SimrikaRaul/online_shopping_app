import 'package:firebase_setup/core/response/api_response.dart';
import 'package:firebase_setup/feature/signup/model/signup_model.dart';

abstract class SignupService {
  Future<ApiResponse<dynamic>> signup(SignUpModel request);
}
