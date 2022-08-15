
import 'package:flutter/material.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';


class MobileFeatureDetermination extends StatelessWidget {
  const MobileFeatureDetermination({Key? key, required this.mobileFeature, required this.description, required this.brandColor}) : super(key: key);

  final String mobileFeature;
  final String description;
  final Color brandColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.centerRight, child: Text(mobileFeature, style: TextStyle(
          fontSize: size16
        ),)),
        Container(
          decoration: BoxDecoration(
            color: brandColor,
            borderRadius: circular12,
          ),
          child:
          Padding(
            padding: const EdgeInsets.fromLTRB(size8, size16, size8, size16),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    description,
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: size18,
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
        gap4,
      ],
    );
  }
}
