import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/cover_comp_bloc/cover_comp_bloc.dart';
import 'package:waffaq_x/controllers/cover_comp_bloc/cover_comp_state.dart';
import 'package:waffaq_x/controllers/glass_comp_bloc/glass_comp_bloc.dart';
import 'package:waffaq_x/controllers/glass_comp_bloc/glass_comp_state.dart';
import 'package:waffaq_x/controllers/screen_comp_bloc/screen_comp_bloc.dart';
import 'package:waffaq_x/controllers/screen_comp_bloc/screen_comp_state.dart';
import 'package:waffaq_x/models/brand_theme_models/mobile_theme.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/utilities/enums/comp_type.dart';
import 'package:waffaq_x/views/widgets/dividers/skinnyDivider.dart';
import 'package:waffaq_x/views/widgets/items_designs/mobile_item_design.dart';
import 'package:waffaq_x/views/widgets/texts/error_occurred.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';
import 'package:waffaq_x/views/widgets/texts/no_results_found.dart';

class CompatibilitiesPage extends StatefulWidget {
  const CompatibilitiesPage({Key? key}) : super(key: key);

  @override
  State<CompatibilitiesPage> createState() => _CompatibilitiesPageState();
}

class _CompatibilitiesPageState extends State<CompatibilitiesPage> {
  CompType type = CompType.screens;

  late MobileTheme mobileTheme;

  late Mobile mobileModel;

  late String brandLogo;

  late Color brandColor;

  @override
  Widget build(BuildContext context) {
    mobileTheme = ModalRoute.of(context)!.settings.arguments as MobileTheme;
    mobileModel = mobileTheme.mobile;
    brandLogo = mobileTheme.brandLogo;
    brandColor = mobileTheme.brandColor;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
        ),
        backgroundColor: whiteColor,
        body: Padding(
            padding: EdgeInsets.only(right: 8.0, bottom: 8.0, left: 8.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Text('$compWithText ${mobileModel.brandName} - ${mobileModel.mobileName}', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  overflow: TextOverflow.fade
                ),),
                gap8,
// categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
// screens checkBox
                    Checkbox(
                      value: (type == CompType.screens) ? true : false,
                      onChanged: (value) {
                        setState(() {
                          type = CompType.screens;
                        });
                      },
                    ),
                    const Text(
                      screensText,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
// covers checkBox
                    Checkbox(
                      value: (type == CompType.covers) ? true : false,
                      onChanged: (value) {
                        setState(() {
                          type = CompType.covers;
                        });
                      },
                    ),
                    const Text(
                      coversText,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
// glasses checkBox
                    Checkbox(
                      value: (type == CompType.glass) ? true : false,
                      onChanged: (value) {
                        setState(() {
                          type = CompType.glass;
                        });
                      },
                    ),
                    const Text(
                      glassText,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SkinnyDivider(),
                gap16,

                if (type == CompType.screens) screenComp(),
                if (type == CompType.covers) coverComp(),
                if (type == CompType.glass) glassComp(),
              ],
            )),
      ),
    );
  }

  BlocBuilder<ScreenCompBloc, ScreenCompState> screenComp() {
    return BlocBuilder<ScreenCompBloc, ScreenCompState>(
      builder: (context, state) {
        if (state is LoadingScreenComp) {
          return const Loading();
        } else if (state is ScreenCompLoadedSuccessfully) {
          if (state.mobilesTheme.isEmpty) {
            return const NoResultsFound();
          }
          return Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '$numOfCompatibilitiesText ${state.mobilesTheme.length}',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.mobilesTheme.length,
                itemBuilder: (context, index) {
                  return MobileItemDesign(
                      mobileTheme: state.mobilesTheme[index]);
                },
              ),
            ],
          );
        } else {
          return const ErrorOccurred();
        }
      },
    );
  }

  BlocBuilder<CoverCompBloc, CoverCompState> coverComp() {
    return BlocBuilder<CoverCompBloc, CoverCompState>(
      builder: (context, state) {
        if (state is LoadingCoverComp) {
          return const Loading();
        } else if (state is CoverCompLoadedSuccessfully) {
          if (state.mobilesTheme.isEmpty) {
            return const NoResultsFound();
          }
          return Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '$numOfCompatibilitiesText ${state.mobilesTheme.length}',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.mobilesTheme.length,
                itemBuilder: (context, index) {
                  return MobileItemDesign(
                      mobileTheme: state.mobilesTheme[index]);
                },
              ),
            ],
          );
        } else {
          return const ErrorOccurred();
        }
      },
    );
  }

  BlocBuilder<GlassCompBloc, GlassCompState> glassComp() {
    return BlocBuilder<GlassCompBloc, GlassCompState>(
      builder: (context, state) {
        if (state is LoadingScreenComp) {
          return const Loading();
        } else if (state is GlassCompLoadedSuccessfully) {
          if (state.mobilesTheme.isEmpty) {
            return const NoResultsFound();
          }
          return Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '$numOfCompatibilitiesText ${state.mobilesTheme.length}',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.mobilesTheme.length,
                itemBuilder: (context, index) {
                  return MobileItemDesign(
                      mobileTheme: state.mobilesTheme[index]);
                },
              ),
            ],
          );
        } else {
          return const ErrorOccurred();
        }
      },
    );
  }
}
