import 'dart:io';
import 'package:firebase_setup/core/utils/helper_utils.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/core/utils/string_consts.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_bloc.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_event.dart';
import 'package:firebase_setup/feature/product/bloc/add_product_state.dart';
import 'package:firebase_setup/feature/product/model/product_model.dart';
import 'package:firebase_setup/shared_widget/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_setup/shared_widget/custom_textformfield.dart';
import 'package:firebase_setup/shared_widget/custom_elevated_button.dart';

class AddProductPage extends StatefulWidget {
  final ProductModel? product; // null = add mode, non-null = edit mode

  AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  bool get isEditMode => widget.product != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(text: widget.product?.price ?? '');
    _descriptionController = TextEditingController(text: widget.product?.description ?? '');
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      context.read<AddProductBloc>().add(ImagePickedEvent(File(pickedFile.path)));
    }
  }

  void _submit(BuildContext context, File? selectedImage) {
    if (_formKey.currentState!.validate()) {
      if (isEditMode) {
        context.read<AddProductBloc>().add(
          UpdateProductButtonEvent(
            id: widget.product!.id!,
            name: _nameController.text,
            price: _priceController.text,
            description: _descriptionController.text,
            existingImageUrl: widget.product!.imageUrl,
            imageFile: selectedImage,
          ),
        );
      } else {
        context.read<AddProductBloc>().add(
          AddProductButtonEvent(
            name: _nameController.text,
            price: _priceController.text,
            description: _descriptionController.text,
            imageFile: selectedImage,
          ),
        );
      }
    }
  }

  void _retry(BuildContext context, File? selectedImage) {
    _submit(context, selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? editProductStr : addProductsStr),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocConsumer<AddProductBloc, AddProductState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == StatusUtils.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? (isEditMode ? productUpdateStr : productAddedStr))),
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
            return NoInternetPage(onPressed: () => _retry(context, state.selectedImage));
          }

          final isLoading = state.status == StatusUtils.loading;
          final selectedImage = state.selectedImage;

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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: selectedImage != null
                                  ? Image.file(selectedImage, height: 180, width: double.infinity, fit: BoxFit.cover)
                                  : (isEditMode && widget.product!.imageUrl.isNotEmpty)
                                      ? Image.network(
                                          widget.product!.imageUrl,
                                          height: 180,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (c, e, s) => _placeholder(),
                                        )
                                      : _placeholder(),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
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
                        CustomElevatedButton(
                          text: isEditMode ? updateProductStr : saveProductStr,
                          backgroundColor: Colors.black,
                          borderRadius: 30,
                          onPressed: isLoading ? null : () => _submit(context, selectedImage),
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

  Widget _placeholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_a_photo_outlined, color: Colors.black45, size: 32),
        SizedBox(height: 8),
        Text(taptoAddProductStr, style: TextStyle(color: Colors.black45)),
      ],
    );
  }
}