import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_setup/core/response/api_response.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/signup/model/signup_model.dart';
import 'package:firebase_setup/feature/signup/service/signup_service.dart';
import 'package:firebase_setup/network/network_service.dart';

class SignupServiceImpl implements SignupService {
  @override
  @override
  Future<ApiResponse<dynamic>> signup(SignUpModel request) async {
    try {
      //check the internet
      final isConnected = await NetworkService.isConnected();
      if (!isConnected) {
        return ApiResponse(
          message: "No Internet Connection",
          type: StatusUtils.noInternet,
        );
      }
      
      // Check if the email already exists
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Signup")
          .where("email", isEqualTo: request.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return ApiResponse(
          message: "Email already exists",
          type: StatusUtils.failure,
        );
      }

      // Save the new user
      await FirebaseFirestore.instance
          .collection("Signup")
          .add(request.toJson());

      return ApiResponse(
        message: "Data Successfully Saved",
        type: StatusUtils.success,
      );
    } catch (e) {
      return ApiResponse(message: e.toString(), type: StatusUtils.failure);
    }
  }
}
