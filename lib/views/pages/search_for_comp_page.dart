import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/all_mobiles_bloc/all_mobiles_bloc.dart';
import 'package:waffaq_x/controllers/all_mobiles_bloc/all_mobiles_state.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/utilities/mobiles_filtration_helper.dart';
import 'package:waffaq_x/views/widgets/assets/search_helper_results.dart';
import 'package:waffaq_x/views/widgets/buttons/wipe_button.dart';
import 'package:waffaq_x/views/widgets/dividers/skinnyDivider.dart';
import 'package:waffaq_x/views/widgets/items_designs/mobile_item_design.dart';
import 'package:waffaq_x/views/widgets/texts/error_occurred.dart';
import 'package:waffaq_x/views/widgets/texts/helper_text.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';
import 'package:waffaq_x/views/widgets/texts/no_results_found.dart';

class SearchForCompPage extends StatefulWidget {
  const SearchForCompPage({Key? key}) : super(key: key);

  @override
  State<SearchForCompPage> createState() => _SearchForCompPageState();
}

class _SearchForCompPageState extends State<SearchForCompPage> {
  final TextEditingController _searchController = TextEditingController();
  final MobilesFiltrationHelper _filtrationHelper = MobilesFiltrationHelper();
  bool _userNotSearching = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: padding8,
        child: ListView(
          children: [
            gap24,
            const HelperText(helperText: searchForCompatibilitiesHelperText),
            gap8,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
// search text field
                Expanded(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      borderRadius: circular12,
                      color: brightGrayColor,
                    ),
                    child: Padding(
                      padding: paddingH8,
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        textDirection: TextDirection.rtl,
                        decoration: const InputDecoration(
                          hintText: searchHintText,
                          hintTextDirection: TextDirection.rtl,
                          border: InputBorder.none,
                          fillColor: whiteColor,
                          focusColor: whiteColor,
                        ),
                        onChanged: (String searchText) {
                          if (searchText.trim().isNotEmpty) {
                            setState(() {
                              _userNotSearching = false;
                            });
                          } else {
                            setState(() {
                              _userNotSearching = true;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
// clear search text
                Padding(
                    padding: paddingH4,
                    child: WipeButton(
                      buttonText: clearText,
                      onPressed: () {
                        setState(() {
                          setState(() {
                            _userNotSearching = true;
                            _searchController.clear();
                          });
                        });
                      },
                    )
                    //clearSearchButtonWidget(),
                    ),
              ],
            ),
            gap16,
            const SkinnyDivider(),
            gap8,
            BlocBuilder<AllMobilesBloc, AllMobilesState>(
              builder: (context, state) {
                if (state is LoadingAllMobiles) {
                  return const Loading();
                } else if (state is MobilesLoadedSuccessfully) {
                  final searchResult =
                      _filtrationHelper.searchResult(
                          mobileTheme: state.mobilesTheme,
                          searchText: _searchController.text);
                  if (_userNotSearching) {
                    return const SearchResultHelper();
                  } else if (searchResult.isEmpty) {
                    return const NoResultsFound();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) {
                        return MobileItemDesign(
                            mobileTheme: searchResult[index]);
                      },
                    );
                  }
                } else {
                  return const ErrorOccurred();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
