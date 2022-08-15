

import 'package:flutter/material.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/constantsIcons.dart';

class UserItemDesign extends StatelessWidget {
  const UserItemDesign({Key? key, required this.name, required this.email, required this.onPressed}) : super(key: key);

  final String name, email;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: brightGrayColor,
          borderRadius: circular12,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                gap8,
                Text(email),
              ],
            ),
            trailing: InkWell(
              onTap: onPressed,
              child: const Icon(
                addIcon,
                color: blackColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
