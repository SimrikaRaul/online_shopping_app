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
    : super(AddProductState(selectedImage: null)) {
    on<ImagePickedEvent>((event, emit) {
      emit(state.copyWith(selectedImage: event.image));
    });

    on<AddProductButtonEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUtils.loading, message: null));
      final String? url = await cloudinaryService.uploadImage(event.imageFile!);

      final response = await productService.addProduct(
        AddProductModel(
          name: event.name.trim(),
          price: event.price.trim(),
          description: event.description.trim(),
          imageUrl: url ?? "",
        ),
      );

      emit(state.copyWith(status: response.type, message: response.message));

      emit(state.copyWith(status: StatusUtils.initial, selectedImage: null));
    });

    on<FetchProductsEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUtils.loading, message: null));

      final response = await productService.getProducts();

      emit(
        state.copyWith(
          status: response.type,
          message: response.message,
          products: response.data ?? [],
        ),
      );
    });

    on<DeleteProductEvent>((event, emit) async {
      final response = await productService.deleteProduct(event.id);

      if (response.type == StatusUtils.success) {
        final updatedProducts = state.products
            .where((p) => p.id != event.id)
            .toList();
        emit(
          state.copyWith(products: updatedProducts, message: response.message),
        );
      } else {
        emit(state.copyWith(message: response.message));
      }
    });
  }
}
