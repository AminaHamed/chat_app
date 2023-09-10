import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class CustomPasswordTextFormField extends StatelessWidget {
  const CustomPasswordTextFormField(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.obscureText})
      : super(key: key);
  final void Function()? onPressed;
  final IconData? icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(icon, color: AppColors.secondaryColor),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 1))),
      ),
    );
  }
}
