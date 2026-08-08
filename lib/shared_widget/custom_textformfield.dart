import 'package:flutter/material.dart';

class CustomTextformField extends StatelessWidget {
  String? labelText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? hintText;
  Color? fillColor;
  bool? filled;
  bool obscureText;
  int? maxLines;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  InputBorder? errorBorder;
  InputBorder? focusedErrorBorder;
  TextEditingController? controller;
  bool readOnly;
  VoidCallback? onTap;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  String? initialValue;

  CustomTextformField({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.hintText,
    this.prefixIcon,
    this.fillColor,
    this.filled = true,
    this.obscureText = false,
    this.maxLines,
    this.onChanged,
    this.validator,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        maxLines: obscureText ? 1 : (maxLines ?? 1),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          fillColor: fillColor,
          filled: filled,
          border: InputBorder.none,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
        ),
      ),
    );
  }
}