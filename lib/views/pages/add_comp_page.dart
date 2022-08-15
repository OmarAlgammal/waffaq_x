import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/add_comp_cubit/add_comp_cubit.dart';
import 'package:waffaq_x/controllers/add_comp_cubit/add_comp_state.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/routes.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/views/models/mobile_theme.dart';
import 'package:waffaq_x/views/widgets/buttons/circular_button.dart';
import 'package:waffaq_x/views/widgets/input/search_box.dart';
import 'package:waffaq_x/views/widgets/show_my_snack_bar.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';

class AddCompPage extends StatefulWidget {
  const AddCompPage({Key? key}) : super(key: key);

  @override
  State<AddCompPage> createState() => _AddCompPageState();
}

class _AddCompPageState extends State<AddCompPage> {
  late Mobile firstMobile, secondMobile;
  String? firstMobileName, secondMobileName;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            addCoversCompatibilitiesText,
          ),
        ),
        body: Padding(
          padding: padding8,
          child: ListView(
            children: [
              gap24,
              gap12,
              const Text(
                chooseFirstDeviceText,
                style: TextStyle(
                  fontSize: size18,
                ),
              ),
// first device search box
              SearchBox(
                title: firstMobileName,
                onPressed: () async {
                  var result = await Navigator.pushNamed(
                      context, AppRoutes.selectMobilePage,
                      arguments: selectFirstMobileText);
                  if (result != null) {
                    firstMobile = result as Mobile;
                    setState(() {
                      firstMobileName = '${firstMobile.brandName} ${firstMobile.mobileName}';
                    });
                  }
                },
              ),
              gap8,
              const Text(
                chooseSecondDeviceText,
                style: TextStyle(
                  fontSize: size18,
                ),
              ),
// second device search box
              SearchBox(
                title: secondMobileName,
                onPressed: () async {
                  var result = await Navigator.pushNamed(
                      context, AppRoutes.selectMobilePage,
                      arguments: selectSecondMobileText);
                  if (result != null) {
                    secondMobile = result as Mobile;
                    setState(() {
                      secondMobileName = '${secondMobile.brandName} ${secondMobile.mobileName}';
                    });
                  }
                },
              ),
              gap24,
              BlocConsumer<AddCompCubit, AddCompState>(
                  listener: (context, state) {
                
                if (state is CompAddedSuccessfully) {
                  return showMySnackBar(
                      context: context,
                      content: coversCompatibilityAddedSuccessfullyText,
                      color: greenColor);
                } else if (state is EachMobileInSeparateGroup){
                  return showMySnackBar(context: context, content: eachMobileInSeparateGroupText, color: redColor);
                }
                else if (state is CompAreAlreadyExist){
                  return showMySnackBar(context: context, content: compAreAlreadyExistText, color: redColor);
                }
                else if (state is FailedToAddComp) {
                  return showMySnackBar(
                      context: context,
                      content: anErrorOccurredText,
                      color: redColor);
                }
              }, builder: (context, state) {
                if (state is AddingComp) {
                  return const Loading();
                }
                return CircularButton(
                    text: additionText,
                    filled: true,
                    onPressed: () {
                      if (firstMobileName == null || secondMobileName == null) {
                        return showMySnackBar(
                            context: context,
                            content: youShouldSelectFirstAndSecondMobileText,
                            color: redColor);
                      }
                      if (firstMobileName == secondMobileName) {
                        return showMySnackBar(
                            context: context,
                            content:
                                firstMobileShouldNotEqualToSecondMobileText,
                            color: redColor);
                      }
                      if (firstMobileName != secondMobileName) {
                        ///TODO: change comp path according to comp type
                        BlocProvider.of<AddCompCubit>(context).addComp(
                            path: coversPath,
                            firstMobile: firstMobile,
                            secondMobile: secondMobile);
                      }
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
