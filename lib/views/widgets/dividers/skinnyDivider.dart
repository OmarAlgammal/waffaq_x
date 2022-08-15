
import 'package:flutter/material.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';

class SkinnyDivider extends StatelessWidget {
  const SkinnyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: brightGrayColor,
      thickness: size1,
      height: size3,
    );
  }
}
