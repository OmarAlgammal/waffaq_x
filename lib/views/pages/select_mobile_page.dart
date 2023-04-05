
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/all_mobiles_bloc/all_mobiles_bloc.dart';
import 'package:waffaq_x/controllers/all_mobiles_bloc/all_mobiles_event.dart';
import 'package:waffaq_x/controllers/all_mobiles_bloc/all_mobiles_state.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/utilities/helpers/mobiles_filtration_helper.dart';
import 'package:waffaq_x/views/widgets/buttons/wipe_button.dart';
import 'package:waffaq_x/views/widgets/dividers/skinnyDivider.dart';
import 'package:waffaq_x/views/widgets/input/search_box.dart';
import 'package:waffaq_x/views/widgets/input/search_box_to_move.dart';
import 'package:waffaq_x/views/widgets/items_designs/mobile_item_design.dart';
import 'package:waffaq_x/views/widgets/texts/error_occurred.dart';
import 'package:waffaq_x/views/widgets/texts/helper_text.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';
import 'package:waffaq_x/views/widgets/texts/no_results_found.dart';

import '../../models/brand_theme_models/mobile_theme.dart';

class SelectMobilePage extends StatefulWidget {
  const SelectMobilePage({Key? key}) : super(key: key);

  @override
  State<SelectMobilePage> createState() => _SelectMobilePageState();
}

class _SelectMobilePageState extends State<SelectMobilePage> {

  final TextEditingController _searchController = TextEditingController();
  final MobilesFiltrationHelper _mobilesHelper = MobilesFiltrationHelper();
  late List<MobileTheme> _searchResult;

  @override
  Widget build(BuildContext context) {
    String argument = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding8,
          child: ListView(
            children: [
              gap24,
              HelperText(helperText: argument),
              gap24,
              Row(
                children: [
                Expanded(
                flex: 1,
                child: SearchBox(searchHint: searchHintText, searchController: _searchController, onChanged: (String searchText) {
                  setState(() {

                  });
                },),
              ),
                  WipeButton(buttonText: clearText, onPressed: (){
                    setState(() {
                      _searchController.clear();
                    });
                  },),
                ],
              ),
              gap16,
              const SkinnyDivider(),
              gap8,
              BlocBuilder<AllMobilesBloc, AllMobilesState>(
                builder: (context, state){
                  if (state is LoadingAllMobiles){
                    return const Loading();
                  }
                  else if (state is MobilesLoadedSuccessfully){
                    /// get search results
                    _searchResult = _mobilesHelper.searchResult(mobileTheme: state.mobilesTheme, searchText: _searchController.text);
                    if (_searchResult.isEmpty){
                      return const NoResultsFound();
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index){
                        return MobileItemDesign(mobileTheme: _searchResult[index], onPressed: (){
                          Navigator.pop(context, _searchResult[index].mobile);
                        },);
                      },
                    );
                  }
                  else {
                    return const ErrorOccurred();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchTextField() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: paddingH8,
        child: TextField(
          controller: _searchController,
          autofocus: true,
          textDirection: TextDirection.rtl,
          onChanged: (String text){
            setState(() {

            });
          },
          decoration: const InputDecoration(
            hintText: searchHintText,
            hintTextDirection: TextDirection.rtl,
            border: InputBorder.none,
            fillColor: whiteColor,
            focusColor: whiteColor,
          ),
        )
      ),
    );
  }
}
