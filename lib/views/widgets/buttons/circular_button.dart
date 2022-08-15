
import 'package:flutter/material.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';


class CircularButton extends StatelessWidget {
  const CircularButton({Key? key, required this.text, this.filled = false, required this.onPressed}) : super(key: key);

  final String text;
  final bool filled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: const Size.fromHeight(size56),
        backgroundColor: (filled)? greenColor: transparentColor,

        shape: const RoundedRectangleBorder(
          borderRadius: circular_infinity,
          side: BorderSide(
              color: greenColor,
              width: size2
          )
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: (filled)? whiteColor: greenColor,
          ),
        ),
      ),
    );
  }
}
