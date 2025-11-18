import 'package:flutter/material.dart';

class CustomTextfield
    extends
        StatelessWidget {
  final String hintname;
  final TextEditingController? controller;
  final bool isObs;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextfield({
    super.key,
    required this.hintname,
    required this.controller,
    required this.isObs,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return TextFormField( 
      onTap: onTap,
      readOnly: readOnly,
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
