import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? type;
  final bool? obscure;
  final Icon? icon;

  const CustomTextFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
    this.type,
    this.obscure = false, this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure!,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(12),
          ),
          label: Text(label),
          suffixIcon: icon,
          fillColor: Colors.grey[200],
          filled: true),
    );
  }
}
