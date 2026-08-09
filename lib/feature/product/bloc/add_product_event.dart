import 'package:equatable/equatable.dart';

class AddProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddProductButtonEvent extends AddProductEvent {
  final String name;
  final String price;
  final String description;

  AddProductButtonEvent({
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  List<Object?> get props => [name, price, description];
}