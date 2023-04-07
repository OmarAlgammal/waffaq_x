
import 'package:flutter/material.dart';

import '../../../utilities/constants/constantsColors.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(this.title, this.icon, this.onTap, {super.key});

  final VoidCallback onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        leading: Icon(
          icon,
          color: blackColor,
        ),
        title: Text(title),
      ),
    );
  }
}
