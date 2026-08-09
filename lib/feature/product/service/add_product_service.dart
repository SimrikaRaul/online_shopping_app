import 'package:firebase_setup/core/response/api_response.dart';
import 'package:firebase_setup/feature/product/model/add_product_model.dart';

abstract class AddProductService {
  Future<ApiResponse<dynamic>> addProduct(AddProductModel request);
}