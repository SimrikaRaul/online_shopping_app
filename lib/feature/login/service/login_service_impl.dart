import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_setup/core/response/api_response.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/login/model/login_model.dart';
import 'package:firebase_setup/feature/login/service/login_service.dart';
import 'package:firebase_setup/network/network_service.dart';

class LoginServiceImpl implements LoginService {
  @override
  Future<ApiResponse<dynamic>> login(LoginModel request) async {
    try {
       final isConnected = await NetworkService.isConnected();
      if (!isConnected) {
        return ApiResponse(
          message: "No Internet Connection",
          type: StatusUtils.noInternet,
        );
      }

      
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Signup")
          .where("email", isEqualTo: request.email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return ApiResponse(
          message: "No account found with this email",
          type: StatusUtils.failure,
        );
      }

      final userDoc = querySnapshot.docs.first.data();
      if (userDoc["password"] != request.password) {
        return ApiResponse(
          message: "Incorrect password",
          type: StatusUtils.failure,
        );
      }

      return ApiResponse(
        message: "Login successful",
        type: StatusUtils.success,
      );
    } catch (e) {
      return ApiResponse(message: e.toString(), type: StatusUtils.failure);
    }
  }
}