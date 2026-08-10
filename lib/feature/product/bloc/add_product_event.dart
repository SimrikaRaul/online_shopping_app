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