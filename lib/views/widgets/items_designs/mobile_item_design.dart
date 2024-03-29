import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/comp_event.dart';
import 'package:waffaq_x/controllers/cover_comp_bloc/cover_comp_bloc.dart';
import 'package:waffaq_x/controllers/glass_comp_bloc/glass_comp_bloc.dart';
import 'package:waffaq_x/controllers/screen_comp_bloc/screen_comp_bloc.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';

import '../../../models/brand_theme_models/mobile_theme.dart';
import '../../../utilities/routing/routes.dart';

class MobileItemDesign extends StatelessWidget {
  const MobileItemDesign({Key? key, required this.mobileTheme, this.onPressed}) : super(key: key);

  final MobileTheme mobileTheme;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: paddingV4,
        child: ListTile(
          onTap: (onPressed != null)? onPressed : (){
            BlocProvider.of<ScreenCompBloc>(context).add(LoadScreenComp(mobile: mobileTheme.mobile));
            BlocProvider.of<GlassCompBloc>(context).add(
                LoadGlassComp(
                    mobile: mobileTheme.mobile));
            BlocProvider.of<CoverCompBloc>(context).add(
                LoadCoversComp(
                    mobile: mobileTheme.mobile));
            Navigator.popAndPushNamed(context, AppRoutes.compatibilitiesPage, arguments: mobileTheme);
          },
            contentPadding: paddingH8,
            tileColor: mobileTheme.brandColor,
            shape: const RoundedRectangleBorder(
              borderRadius: circular12,
            ),
            title: Text(
              '${mobileTheme.mobile.brandName} ${mobileTheme.mobile.mobileName}',
              style: const TextStyle(color: whiteColor),
            ),
            trailing: IconButton(
              padding: padding0,
              icon: const Icon(
                Icons.article_outlined,
                color: whiteColor,
              ),
              onPressed: (){
                Navigator.pushNamed(context, AppRoutes.mobilePage, arguments: mobileTheme);
              },
            )
        ),
      ),
    );
  }
}
