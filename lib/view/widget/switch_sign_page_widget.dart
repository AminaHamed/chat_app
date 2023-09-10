import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class SwitchSignPageWidget extends StatelessWidget {
  SwitchSignPageWidget(
      {Key? key, required this.onTap, required this.text1, required this.text2})
      : super(key: key);
  void Function()? onTap;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        InkWell(
          onTap: onTap,
          child: Text(text2,
              style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
