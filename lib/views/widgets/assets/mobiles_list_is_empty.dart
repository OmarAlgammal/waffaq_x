
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/texts/paths.dart';

class MobilesListIsEmpty extends StatelessWidget {
  const MobilesListIsEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SvgPicture.asset(emptyListImagePath, color: blackColor,));
  }
}
