import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_setup/core/response/api_response.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/product/model/add_product_model.dart';
import 'package:firebase_setup/feature/product/service/add_product_service.dart';


class AddProductServiceImpl implements  AddProductService{
  @override
  Future<ApiResponse<dynamic>> addProduct(AddProductModel request) async {
    try {
      await FirebaseFirestore.instance.collection("Products").add(request.toJson());

      return ApiResponse(
        message: "Product added successfully",
        type: StatusUtils.success,
      );
    } catch (e) {
      return ApiResponse(message: e.toString(), type: StatusUtils.failure);
    }
  }
}