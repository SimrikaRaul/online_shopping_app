import 'dart:io';
import 'package:equatable/equatable.dart';

class AddProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddProductButtonEvent extends AddProductEvent {
  final String name;
  final String price;
  final String description;
  final File? imageFile;

  AddProductButtonEvent({
    required this.name,
    required this.price,
    required this.description,
    this.imageFile,
  });

  @override
  List<Object?> get props => [name, price, description, imageFile];
}

class FetchProductsEvent extends AddProductEvent {}

class ImagePickedEvent extends AddProductEvent {
  final File image;

  ImagePickedEvent(this.image);

  @override
  List<Object?> get props => [image];
}


class DeleteProductEvent extends AddProductEvent {
  final String id;

  DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}



class UpdateProductButtonEvent extends AddProductEvent {
  final String id;
  final String name;
  final String price;
  final String description;
  final String existingImageUrl;
  final File? imageFile;

  UpdateProductButtonEvent({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.existingImageUrl,
    this.imageFile,
  });

  @override
  List<Object?> get props => [id, name, price, description, existingImageUrl, imageFile];
}
