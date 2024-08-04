import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isProductName;final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  const CustomTextFormField({
    super.key,this.onChanged,
    
    required this.isProductName,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isProductName ? 180 : 100,
      height: 80,
      child: TextFormField(onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(18),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(18),
          ),
          hintText: labelText,
        ),
        controller: controller,
        keyboardType: keyboardType,
      ),
    );
  }
}
