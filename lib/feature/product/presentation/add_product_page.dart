import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/core/utils/string_consts.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_bloc.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_event.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_setup/shared_widget/custom_textformfield.dart';
import 'package:firebase_setup/shared_widget/custom_elevated_button.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(addProductsStr),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextformField(
                  hintText: productNameStr,
                  controller: _nameController,
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? productNameValidationStr : null,
                ),
                CustomTextformField(
                  hintText: priceStr,
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? priceValidationStr : null,
                ),
                CustomTextformField(
                  hintText: descriptionStr,
                  controller: _descriptionController,
                  maxLines: 4,
                ),
                SizedBox(height: 20),
                BlocConsumer<AddProductBloc, AddProductState>(
                  listener: (context, state) {
                    if (state.status == StatusUtils.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message ?? 'Product added')),
                      );
                      Navigator.pop(context);
                    } else if (state.status == StatusUtils.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message ?? 'Failed to add product')),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.status == StatusUtils.loading;
                    return CustomElevatedButton(
                      backgroundColor: Colors.black,
                      borderRadius: 30,
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AddProductBloc>().add(
                                  AddProductButtonEvent(
                                    name: _nameController.text,
                                    price: _priceController.text,
                                    description: _descriptionController.text,
                                  ),
                                );
                              }
                            },
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(saveProductStr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}