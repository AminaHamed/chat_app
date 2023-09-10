import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      required this.hitText,
      required this.icon,
      this.controller,
      this.validator})
      : super(key: key);
  final String hitText;
  final IconData icon;
  final TextEditingController? controller;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            hintText: hitText,
            prefixIcon: Icon(
              icon,
              color: AppColors.secondaryColor,
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1))),
      ),
    );
  }
}
