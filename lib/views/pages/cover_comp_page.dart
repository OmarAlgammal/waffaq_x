import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waffaq_x/controllers/all_comp_controller.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/utilities/helpers/mobiles_filtration_helper.dart';
import 'package:waffaq_x/views/widgets/dividers/thickDivider.dart';
import 'package:waffaq_x/views/widgets/items_designs/comp_item_design.dart';
import 'package:waffaq_x/views/widgets/items_designs/mobile_item_design.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';
import 'package:waffaq_x/views/widgets/texts/no_results_found.dart';

import '../../models/brand_theme_models/brand_theme.dart';

class CoverCompPage extends StatefulWidget {
  const CoverCompPage({Key? key}) : super(key: key);

  @override
  State<CoverCompPage> createState() => _CoverCompPageState();
}

class _CoverCompPageState extends State<CoverCompPage> {
  final MobilesFiltrationHelper _filtrationHelper = MobilesFiltrationHelper();
  final AllCompController _allCompController = AllCompController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: true,
          elevation: size0,
          title: const Text(
            coversCompatibilitiesText,
          ),
        ),
        body: Padding(
          padding: padding8,
          child: Center(
            child: StreamBuilder<List<List<String>>>(
              stream: _allCompController.allCoversComp(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                } else {
                  if (snapshot.data == null) {
                    return const NoResultsFound();
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, firstIndex) {
                        List<BrandTheme> idsThemes = _filtrationHelper
                            .getIdsWithTheme(ids: snapshot.data![firstIndex]);
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: idsThemes.length,
                              itemBuilder: (context, index) {
                                return CompItemDesign(
                                    idTheme: idsThemes[index],
                                    onPressed: () {});
                              },
                            ),
                            gap16,
                            if (snapshot.data!.length - 1 != firstIndex)
                              const ThickDivider(),
                            gap16,
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
