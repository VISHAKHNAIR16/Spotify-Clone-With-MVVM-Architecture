import 'package:flutter/material.dart';

class CustomTextfield
    extends
        StatelessWidget {
  final String hintname;
  final TextEditingController controller;
  final bool isObs;

  const CustomTextfield({
    super.key,
    required this.hintname,
    required this.controller,
    required this.isObs,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintname,
      ),
      controller: controller,
      obscureText: isObs,
      validator:(value) {
            if (value!.trim().isEmpty) {
              return "$hintname is missing";
            }
            return null;
          },
    );
  }
}
