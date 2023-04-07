

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/add_data_cubit/add_data_cubit.dart';
import 'package:waffaq_x/controllers/add_data_cubit/add_data_state.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/views/widgets/buttons/back_arrow.dart';
import 'package:waffaq_x/views/widgets/buttons/circular_button.dart';
import 'package:waffaq_x/views/widgets/show_my_snack_bar.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';

class AddMobilePage extends StatefulWidget {
  const AddMobilePage({Key? key}) : super(key: key);

  @override
  State<AddMobilePage> createState() => _AddMobilePageState();
}

class _AddMobilePageState extends State<AddMobilePage> {
  String _brandName = '';
  bool _hasNotch = false;
  bool _curvedDisplay = false;

  final mobileFromKey = GlobalKey<FormState>();
  TextEditingController mobileNameController = TextEditingController();
  TextEditingController displaySizeController = TextEditingController();
  TextEditingController displayController = TextEditingController();
  TextEditingController storageAndRamController = TextEditingController();
  TextEditingController camerasController = TextEditingController();
  TextEditingController processorController = TextEditingController();
  TextEditingController osController = TextEditingController();
  TextEditingController batteryController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            newPhoneSpecificationsText,
          ),
        ),
        body: Padding(
          padding: padding16,
          child: ListView(
            padding: padding0,
            children: [
              gap8,
              addNewMobileForm(),
              gap24,
              BlocConsumer<AddDataCubit, AddDataState>(
                listener: (context, state){
                  if (state is DataAddedSuccessfully){
                    showMySnackBar(context: context, content: mobileAddedSuccessfullyText, color: Colors.green);
                    mobileNameController.clear();
                        displaySizeController.clear();
                        displayController.clear();
                    storageAndRamController.clear();
                    camerasController.clear();
                    processorController.clear();
                    osController.clear();
                    batteryController.clear();
                  }else if (state is FailedToAddData){
                    showMySnackBar(context: context, content: anErrorOccurredText, color: Colors.red);
                  }
                },
                builder: (context, state){
                  if (state is AddingData){
                    return const Loading();
                  }
                  return CircularButton(text: additionText, filled: true, onPressed: (){
                    if (mobileFromKey.currentState!.validate()){
                      Mobile mobileModel = Mobile(
                          brandName: _brandName,
                          mobileId: mobileNameController.text,
                          mobileName: mobileNameController.text,
                          displaySize: double.parse(displaySizeController.text),
                          display: displayController.text,
                          processor: processorController.text,
                          storageAndRam: storageAndRamController.text,
                          cameras: camerasController.text,
                          battery: batteryController.text,
                          os: osController.text,
                          hasNotch: _hasNotch, curvedDisplay: _curvedDisplay
                      );
                      String mobileName = '${mobileModel.brandName} ${mobileModel.mobileName}';
                      BlocProvider.of<AddDataCubit>(context).addData(path: '${FireStorePathes.mobilesPath}$mobileName', data: mobileModel.toJson());
                    }
                  });

                },

              ),
              gap8,
            ],
          ),
        ),
      ),
    );
  }

  addNewMobileForm(){
    return Form(
      key: mobileFromKey,
      child: Column(
        children: [
// brand name
          DropdownButtonFormField<String>(
            isExpanded: true,
            hint: const Text(
              choiceBrandText,
            ),
            onChanged: (value) {
              _brandName = value!;
            },
            validator: (value){
              if (value == null){
                return choiceBrandText;
              }
              return null;
            },
            items: brandsNamesTextsList
                .map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                ),
              );
            }).toList(),
          ),
// mobile name
          TextFormField(
            decoration: const InputDecoration(
              labelText: mobileNameHintText,
            ),
            controller: mobileNameController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return mobileNameErrorText;
              }
              return null;
            },
          ),
// processor field
          TextFormField(
            decoration: const InputDecoration(
              labelText: processorHintText,
            ),
            controller: processorController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return processorErrorText;
              }
              return null;
            },
          ),
// storage and ram field
          TextFormField(
            decoration: const InputDecoration(
              labelText: storageAndRamHintText,
            ),
            keyboardType: TextInputType.text,
            controller: storageAndRamController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return storageAndRamErrorText;
              }
              return null;
            },
          ),
// cameras field
          TextFormField(
            decoration: const InputDecoration(
              labelText: mainCameraHintText,
            ),
            keyboardType: TextInputType.text,
            controller: camerasController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return mainCameraErrorText;
              }
              return null;
            },
          ),
// display field
          TextFormField(
            decoration: const InputDecoration(
              labelText: displayText,
            ),
            keyboardType: TextInputType.text,
            controller: displayController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return displayErrorText;
              }
              return null;
            },
          ),
// os field
          TextFormField(
            decoration: const InputDecoration(
              labelText: osHintText,
            ),
            controller: osController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return osErrorText;
              }
              return null;
            },
          ),
// battery field
          TextFormField(
            decoration: const InputDecoration(
              labelText: batteryHintText,
            ),
            controller: batteryController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return batteryErrorText;
              }
              return null;
            },
          ),
// display size
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: displaySizeHintText,
            ),
            controller: displaySizeController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return displaySizeErrorText;
              }
              return null;
            },
          ),
          gap16,
          Directionality(
            textDirection: TextDirection.ltr,
            child: CheckboxListTile(
              contentPadding: padding0,

              title: const Text(
                notchText,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: size16,
                ),
              ),
              value: _hasNotch,
              onChanged: (value){
                setState(() {
                  _hasNotch = value!;
                });
              },
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: CheckboxListTile(
              contentPadding: padding0,
              title: const Text(curvedDisplayText, textDirection: TextDirection.rtl,),
              value: _curvedDisplay,
              onChanged: (value){
                setState(() {
                  _curvedDisplay = value!;
                });
              },
            ),
          ),
        ],

      ),
    );
  }

}
