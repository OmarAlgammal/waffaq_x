
import 'package:flutter/material.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key, required this.searchHint, required this.searchController, required this.onChanged}) : super(key: key);

  final TextEditingController searchController;
  final String searchHint;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: circular12,
        color: brightGrayColor,
      ),
      child: Padding(
        padding: paddingH8,
        child: TextField(
          controller: searchController,
          autofocus: true,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: searchHint,
            hintTextDirection: TextDirection.rtl,
            border: InputBorder.none,
            fillColor: whiteColor,
            focusColor: whiteColor,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

