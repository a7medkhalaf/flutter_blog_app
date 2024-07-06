import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final String hintText;
  final int? maxLines;
  final TextEditingController controller;
  const BlogEditor({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      maxLines: maxLines,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is required!';
        }
        return null;
      },
    );
  }
}
