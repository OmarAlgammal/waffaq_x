import 'package:flutter/material.dart';

import '../../../utilities/constants/constantsColors.dart';
import '../../../utilities/constants/constantsDimens.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(this.text, this.onPressed, {super.key});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        onPressed();
      },
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        style: const TextStyle(fontSize: size16, color: blackColor),
      ),
    );
  }
}
