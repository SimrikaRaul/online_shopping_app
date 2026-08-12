import 'package:equatable/equatable.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/product/model/product_model.dart';

class SearchState extends Equatable {
  final StatusUtils status;
  final String query;
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final String? message;

  SearchState({
    this.status = StatusUtils.initial,
    this.query = '',
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.message,
  });

  SearchState copyWith({
    StatusUtils? status,
    String? query,
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    String? message,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, query, allProducts, filteredProducts, message];
}