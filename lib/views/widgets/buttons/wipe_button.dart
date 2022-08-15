
import 'package:flutter/material.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsIcons.dart';

class WipeButton extends StatelessWidget {
  const WipeButton({Key? key, this.buttonText, required this.onPressed}) : super(key: key);

  final String? buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: (buttonText != null)? Text(
          buttonText!,
        ) :
        const Icon(wipeIcon, color: whiteColor,),

    );
  }
}
