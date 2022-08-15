
import 'package:flutter/material.dart';
import '../../../utilities/constants/texts/texts.dart';


class NoResultsFound extends StatelessWidget {
  const NoResultsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        NoResultsFoundText,
      ),
    );
  }
}
