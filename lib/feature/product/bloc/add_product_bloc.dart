import 'package:firebase_setup/core/utils/cloudinary_service.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_event.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_state.dart';
import 'package:firebase_setup/feature/product/model/add_product_model.dart';
import 'package:firebase_setup/feature/product/service/add_product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductService productService;
  final CloudinaryService cloudinaryService;

  AddProductBloc(this.productService, this.cloudinaryService)
    : super(AddProductState()) {
    on<AddProductButtonEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUtils.loading, message: null));
      final String? url = await cloudinaryService.uploadImage(event.imageFile!);

      final response = await productService.addProduct(
        AddProductModel(
          name: event.name.trim(),
          price: event.price.trim(),
          description: event.description.trim(),
          imageUrl: url ?? ""
        ),
      );

      emit(state.copyWith(status: response.type, message: response.message));
    });
  }
}
