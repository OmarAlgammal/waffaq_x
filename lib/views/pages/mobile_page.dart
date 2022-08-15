
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/views/models/arguments/mobile_page_arguments.dart';
import 'package:waffaq_x/views/models/mobile_theme.dart';
import 'package:waffaq_x/views/widgets/items_designs/mobile_feature_item_desing.dart';

import '../../utilities/constants/constantsIcons.dart';

class MobilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MobilePageArguments arguments = ModalRoute.of(context)!.settings.arguments as MobilePageArguments;
    Mobile mobile = arguments.mobileTheme.mobile;
    Color brandColor = arguments.mobileTheme.brandColor;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: arguments.mobileTheme.brandColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: arguments.mobileTheme.brandColor,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(arguments.mobileTheme.brandLogo),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                rightArrowIcon,
                color: whiteColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(size8, size8, size8, size0),
        child: ListView(
          children: [
            gap8,
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: circular12,
                    color: brandColor
                  ),
                  child: Padding(
                    padding: padding12,
                    child: Text(
                      mobile.mobileName,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: size24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MobileFeatureDetermination(mobileFeature: displayText, description: mobile.displaySize.toString(), brandColor: brandColor),
                MobileFeatureDetermination(mobileFeature: processorText, description: mobile.processor.toString(), brandColor: brandColor),
                MobileFeatureDetermination(mobileFeature: storageAndRamText, description: mobile.storageAndRam.toString(), brandColor: brandColor),
                MobileFeatureDetermination(mobileFeature: mainCameraHintText, description: mobile.mainCameras.toString(), brandColor: brandColor),
                MobileFeatureDetermination(mobileFeature: selfieCameraHintText, description: mobile.selfieCameras.toString(), brandColor: brandColor),
                MobileFeatureDetermination(mobileFeature: batteryText, description: mobile.battery.toString(), brandColor: brandColor),
                MobileFeatureDetermination(mobileFeature: osText, description: mobile.os.toString(), brandColor: brandColor),
                MobileFeatureDetermination(mobileFeature: selfieCameraHintText, description: mobile.selfieCameras.toString(), brandColor: brandColor),
              ],
            )
          ],
        ),
      ),

    );
  }
}
