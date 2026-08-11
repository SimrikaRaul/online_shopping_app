import 'dart:io';
import 'package:firebase_setup/core/utils/helper_utils.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/core/utils/string_consts.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_bloc.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_event.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_state.dart';
import 'package:firebase_setup/shared_widget/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_setup/shared_widget/custom_textformfield.dart';
import 'package:firebase_setup/shared_widget/custom_elevated_button.dart';

class AddProductPage extends StatefulWidget {
  AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _selectedImage;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      context.read<AddProductBloc>().add(
        ImagePickedEvent(File(pickedFile.path)),
      );
    }
  }

  void _submit(BuildContext context, AddProductState state) {
    if (_formKey.currentState!.validate()) {
      _dispatch(context, state);
    }
  }

  void _retry(BuildContext context, AddProductState state) {
    _dispatch(context, state);
  }

  void _dispatch(BuildContext context, AddProductState state) {
    context.read<AddProductBloc>().add(
      AddProductButtonEvent(
        name: _nameController.text,
        price: _priceController.text,
        description: _descriptionController.text,
        imageFile: state.selectedImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(addProductsStr),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocConsumer<AddProductBloc, AddProductState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == StatusUtils.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? productAddedStr)),
            );
            Navigator.pop(context);
          } else if (state.status == StatusUtils.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? failedProductAddStr)),
            );
          }
        },
        builder: (context, state) {
          if (state.status == StatusUtils.noInternet) {
            return NoInternetPage(onPressed: () => _retry(context, state));
          }

          final isLoading = state.status == StatusUtils.loading;
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _pickImage(context),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: state.selectedImage == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.black45,
                                        size: 32,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        taptoAddProductStr,
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ],
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      state.selectedImage!,
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextformField(
                          hintText: productNameStr,
                          controller: _nameController,
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? productNameValidationStr
                              : null,
                        ),
                        CustomTextformField(
                          hintText: priceStr,
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? priceValidationStr
                              : null,
                        ),
                        CustomTextformField(
                          hintText: descriptionStr,
                          controller: _descriptionController,
                          maxLines: 4,
                        ),
                        SizedBox(height: 20),
                        CustomElevatedButton(
                          text: saveProductStr,
                          backgroundColor: Colors.black,
                          borderRadius: 30,
                          onPressed: isLoading
                              ? null
                              : () => _submit(context, state),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading) backdropFilter(context),
            ],
          );
        },
      ),
    );
  }
}
