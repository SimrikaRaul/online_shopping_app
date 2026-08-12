import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_setup/core/response/api_response.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/product/model/add_product_model.dart';
import 'package:firebase_setup/feature/product/model/product_model.dart';
import 'package:firebase_setup/feature/product/service/add_product_service.dart';
import 'package:firebase_setup/network/network_service.dart';

class AddProductServiceImpl implements AddProductService {
  @override
  Future<ApiResponse<dynamic>> addProduct(AddProductModel request) async {
    try {
      final isConnected = await NetworkService.isConnected();
      if (!isConnected) {
        return ApiResponse(
          message: "No Internet Connection",
          type: StatusUtils.noInternet,
        );
      }
      await FirebaseFirestore.instance
          .collection("Products")
          .add(request.toJson());

      return ApiResponse(
        message: "Product added successfully",
        type: StatusUtils.success,
      );
    } catch (e) {
      return ApiResponse(message: e.toString(), type: StatusUtils.failure);
    }
  }

  @override
  Future<ApiResponse<List<ProductModel>>> getProducts() async {
    try {
      final isConnected = await NetworkService.isConnected();
      if (!isConnected) {
        return ApiResponse(
          message: "No Internet Connection",
          type: StatusUtils.noInternet,
        );
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection("Products")
          .get();
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
          .toList();

      return ApiResponse(
        message: "Fetched successfully",
        type: StatusUtils.success,
        data: products,
      );
    } catch (e) {
      return ApiResponse(message: e.toString(), type: StatusUtils.failure);
    }
  }

  @override
  Future<ApiResponse<dynamic>> deleteProduct(String id) async {
    try {
      final isConnected = await NetworkService.isConnected();
      if (!isConnected) {
        return ApiResponse(
          message: "No Internet Connection",
          type: StatusUtils.noInternet,
        );
      }
      await FirebaseFirestore.instance.collection("Products").doc(id).delete();
      return ApiResponse(message: "Product deleted", type: StatusUtils.success);
    } catch (e) {
      return ApiResponse(message: e.toString(), type: StatusUtils.failure);
    }
  }

  @override
  Future<ApiResponse<dynamic>> updateProduct(ProductModel request) async {
    try {
      final isConnected = await NetworkService.isConnected();
      if (!isConnected) {
        return ApiResponse(
          message: "No Internet Connection",
          type: StatusUtils.noInternet,
        );
      }

      await FirebaseFirestore.instance
          .collection("Products")
          .doc(request.id)
          .update(request.toJson());

      return ApiResponse(message: "Product updated", type: StatusUtils.success);
    } catch (e) {
      return ApiResponse(message: e.toString(), type: StatusUtils.failure);
    }
  }
}
