
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsIcons.dart';

class BackArrow extends StatelessWidget {
  BackArrow({Key? key, this.onPressed, this.color = blackColor}) : super(key: key);

  VoidCallback? onPressed;
  Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          rightArrowIcon,
          color: color,
        ),
        onPressed: (onPressed != null)? onPressed: () {
          Navigator.pop(context);
        });
  }
}
