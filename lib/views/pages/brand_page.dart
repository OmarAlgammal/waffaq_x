import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waffaq_x/controllers/brand_mobiles_bloc/brand_mobiles_bloc.dart';
import 'package:waffaq_x/controllers/brand_mobiles_bloc/brand_mobiles_event.dart';
import 'package:waffaq_x/controllers/brand_mobiles_bloc/brand_mobiles_state.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/constantsIcons.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/utilities/mobiles_filtration_helper.dart';
import 'package:waffaq_x/views/models/arguments/brandPageArguments.dart';
import 'package:waffaq_x/views/models/mobile_theme.dart';
import 'package:waffaq_x/views/widgets/assets/mobiles_list_is_empty.dart';
import 'package:waffaq_x/views/widgets/buttons/back_arrow.dart';
import 'package:waffaq_x/views/widgets/buttons/wipe_button.dart';
import 'package:waffaq_x/views/widgets/items_designs/mobile_item_design.dart';
import 'package:waffaq_x/views/widgets/texts/error_occurred.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';
import 'package:waffaq_x/views/widgets/texts/no_results_found.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({Key? key}) : super(key: key);

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  bool _searching = false;
  final _searchController = TextEditingController();
  final MobilesFiltrationHelper _filtrationHelper = MobilesFiltrationHelper();

  late BrandPageArguments _arguments;

  @override
  Widget build(BuildContext context) {
    _arguments =
        ModalRoute.of(context)!.settings.arguments as BrandPageArguments;
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: _searching ? appBarForSearch() : myAppBar(),
        body: Padding(
          padding: padding8,
          child: ListView(
            children: [
              gap12,
              const Align(
                alignment: Alignment.centerRight,
                child: Text(mobilesListText),
              ),
              BlocBuilder<BrandMobilesBloc, BrandMobilesState>(
                builder: (context, state) {
                  if (state is LoadingBrandMobiles) {
                    return const Loading();
                  } else if (state is BrandMobilesLoadedSuccessfully) {
                    /// convert list of mobiles to list of mobile theme

                    /// if user searching
                    if (_searching) {
                      List<MobileTheme> searchResults =
                          _filtrationHelper.searchResult(
                              mobileTheme: state.mobilesTheme,
                              searchText: _searchController.text);
                      if (searchResults.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            return MobileItemDesign(
                                mobileTheme: searchResults[index]);
                          },
                        );
                      }

                      /// if no search result
                      return const NoResultsFound();
                    }

                    /// if there is no mobiles
                    if (state.mobilesTheme.isEmpty) {
                      return const MobilesListIsEmpty();
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.mobilesTheme.length,
                        itemBuilder: (context, index) {
                          return MobileItemDesign(
                              mobileTheme: state.mobilesTheme[index]);
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
        ));
  }

  AppBar myAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: _arguments.brandColor,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: _arguments.brandColor,
      elevation: size12,
      shadowColor: _arguments.brandColor,
      title: Align(
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            _arguments.logoPath,
            color: whiteColor,
          )),
      actions: [
        IconButton(
          icon: const Icon(
            searchIcon,
            color: whiteColor,
          ),
          onPressed: () {
            setState(() {
              _searching = true;
            });
          },
        ),
        SizedBox(
          height: size24,
          width: size24,
          child: IconButton(
              icon: const Icon(
                rightArrowIcon,
                color: whiteColor,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              }),
        ),
        gap16
      ],
    );
  }

  AppBar appBarForSearch() {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: _arguments.brandColor,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: _arguments.brandColor,
      titleSpacing: size8,
      elevation: size12,
      shadowColor: _arguments.brandColor,
      title: TextFormField(
        controller: _searchController,
        onChanged: (searchText) {
          setState(() {
            // to rebuild the page only
          });
        },
        autofocus: true,
        style: const TextStyle(color: whiteColor),
        decoration: const InputDecoration(
            focusColor: whiteColor,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: whiteColor,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: grayColor,
            ))),
      ),
      actions: [
        /// wipe icon button
        WipeButton(
          onPressed: () {
            setState(() {
              _searchController.clear();
            });
          },
        ),
        gap8,

        /// back icon button
        BackArrow(
          color: whiteColor,
          onPressed: () {
            setState(() {
              _searching = false;
            });
          },
        )
      ],
    );
  }
}
