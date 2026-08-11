import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/product/model/product_model.dart';

class AddProductState extends Equatable {
  final StatusUtils status;
  final String? message;
  final List<ProductModel> products;
  final File? selectedImage;

  AddProductState({
    this.status = StatusUtils.initial,
    this.message,
    this.products = const [],
    this.selectedImage,
  });

  AddProductState copyWith({
    StatusUtils? status,
    String? message,
    List<ProductModel>? products,
    File? selectedImage,

  }) {
    return AddProductState(
      status: status ?? this.status,
      message: message,
      products: products ?? this.products,
       selectedImage: selectedImage ?? this.selectedImage,
    );
  }

  @override
  List<Object?> get props => [status, message, products,selectedImage];
}