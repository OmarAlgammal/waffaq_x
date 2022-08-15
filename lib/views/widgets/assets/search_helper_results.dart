
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/texts/paths.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';

class SearchResultHelper extends StatelessWidget {
  const SearchResultHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(searchHelperImagePath,),
        gap8,
        const Text(
          searchResultHelperText,
        )
      ],
    );
  }
}
