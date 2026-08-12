import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/feature/product/model/product_model.dart';
import 'package:firebase_setup/feature/product/service/add_product_service.dart';
import 'package:firebase_setup/feature/search/bloc/search_event.dart';
import 'package:firebase_setup/feature/search/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AddProductService productService;

  SearchBloc(this.productService) : super(SearchState()) {
    on<LoadSearchProductsEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUtils.loading, message: null));

      final response = await productService.getProducts();

      emit(state.copyWith(
        status: response.type,
        message: response.message,
        allProducts: response.data ?? [],
        filteredProducts: _filter(response.data ?? [], state.query),
      ));
    });

    on<SearchQueryChangedEvent>((event, emit) {
      emit(state.copyWith(
        query: event.query,
        filteredProducts: _filter(state.allProducts, event.query),
      ));
    });
  }
  List<ProductModel> _filter(List<ProductModel> products, String query) {
    if (query.trim().isEmpty) return [];
    final lower = query.toLowerCase();
    return products.where((p) => p.name.toLowerCase().contains(lower)).toList();
  }
}