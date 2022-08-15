
import 'package:flutter/material.dart';

import '../../../utilities/constants/texts/texts.dart';


class ErrorOccurred extends StatelessWidget {
  const ErrorOccurred({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          anErrorOccurredText,
        ),
      ],
    );
  }
}
