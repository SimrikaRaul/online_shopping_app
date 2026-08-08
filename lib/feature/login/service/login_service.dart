import 'package:firebase_setup/core/response/api_response.dart';
import 'package:firebase_setup/feature/login/model/login_model.dart';

abstract class LoginService {
  Future<ApiResponse<dynamic>> login(LoginModel request);
}
