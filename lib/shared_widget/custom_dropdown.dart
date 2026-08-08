import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  List<String> list;
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? labelText;
  String? hintText;
  Function(String?)? onChanged;
  String? Function(String?)? validator;

  CustomDropDown({
    super.key,
    this.suffixIcon,
    required this.list,
    required this.onChanged,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: list
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: onChanged,
      validator: validator ?? (value) {
        if (value == null || (value as String).isEmpty) {
          return '${labelText ?? 'This field'} is required';
        }
        return null;
      },
    );
  }
}