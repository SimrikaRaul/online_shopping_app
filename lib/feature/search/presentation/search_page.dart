import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/core/utils/string_consts.dart';
import 'package:firebase_setup/feature/search/bloc/search_bloc.dart';
import 'package:firebase_setup/feature/search/bloc/search_event.dart';
import 'package:firebase_setup/feature/search/bloc/search_state.dart';
import 'package:firebase_setup/shared_widget/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(LoadSearchProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextformField(
                hintText: searchProductsStr,
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.grey[100],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                onChanged: (value) {
                  context.read<SearchBloc>().add(
                    SearchQueryChangedEvent(value),
                  );
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.status == StatusUtils.loading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state.query.trim().isEmpty) {
                      return Center(
                        child: Text(
                          searchProductForStr,
                          style: TextStyle(color: Colors.black38),
                        ),
                      );
                    }

                    if (state.filteredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No products found for "${state.query}"',
                          style: TextStyle(color: Colors.black38),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final p = state.filteredProducts[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  p.imageUrl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        width: 70,
                                        height: 70,
                                        color: Colors.grey[200],
                                      ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '\$ ${p.price}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );    
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
