import 'package:flutter/material.dart';
import '../../utilities/constants/constantsDimens.dart';

void showMySnackBar({required BuildContext context, required String content, required Color color}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Text(
            content,
          textDirection: TextDirection.rtl,
        ),
        margin: const EdgeInsets.only(
          bottom: size86,
          right: size8,
          left: size8
        ),
      )
  );
}