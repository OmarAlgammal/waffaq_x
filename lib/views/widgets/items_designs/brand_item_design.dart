import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waffaq_x/controllers/brand_mobiles_bloc/brand_mobiles_bloc.dart';
import 'package:waffaq_x/controllers/brand_mobiles_bloc/brand_mobiles_event.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/constantsIcons.dart';
import 'package:waffaq_x/models/arguments/brandPageArguments.dart';

import '../../../utilities/routing/routes.dart';

class BrandItemDesign extends StatelessWidget {
  const BrandItemDesign(
      {Key? key,
      required this.brandName,
      required this.logoPath,
      required this.brandColor})
      : super(key: key);

  final String brandName, logoPath;
  final Color brandColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size64,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: brandColor,
          shape: const RoundedRectangleBorder(
            borderRadius: circular12,
          ),
        ),
        onPressed: () {
          BlocProvider.of<BrandMobilesBloc>(context).add(LoadBrandMobiles(brandName: brandName));
          Navigator.pushNamed(context, AppRoutes.brandPage,
              arguments: BrandPageArguments(
                  brandName: brandName,
                  logoPath: logoPath,
                  brandColor: brandColor));
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: padding8,
            child: SvgPicture.asset(
              logoPath,
              color: whiteColor,
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
      ),
    );
  }
}
