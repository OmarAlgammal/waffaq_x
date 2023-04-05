import 'package:flutter/material.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/constantsIcons.dart';

import '../../../models/brand_theme_models/brand_theme.dart';

class CompItemDesign extends StatelessWidget {
  const CompItemDesign(
      {Key? key, required this.idTheme, required this.onPressed})
      : super(key: key);

  final BrandTheme idTheme;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: paddingV4,
        child: ListTile(
            contentPadding: paddingH8,
            tileColor: idTheme.brandColor,
            shape: const RoundedRectangleBorder(
              borderRadius: circular12,
            ),
            onTap: () {
              //Navigator.pushNamed(context, AppRoutes.compatibilitiesPage, arguments: CompPageArg(mobileTheme: mobileWithTheme));
            },
            title: Text(
              idTheme.mobileName,
              style: const TextStyle(color: whiteColor),
            ),
            trailing: IconButton(
              padding: padding0,
              icon: const Icon(
                removeCircularIcon,
                color: whiteColor,
              ),
              onPressed: onPressed,
            )),
      ),
    );
  }
}
