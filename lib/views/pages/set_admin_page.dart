import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/add_data_cubit/add_data_cubit.dart';
import 'package:waffaq_x/controllers/add_data_cubit/add_data_state.dart';
import 'package:waffaq_x/controllers/users_controller.dart';
import 'package:waffaq_x/models/admin/admin_model.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/views/widgets/dividers/skinnyDivider.dart';
import 'package:waffaq_x/views/widgets/items_designs/users_item_design.dart';
import 'package:waffaq_x/views/widgets/show_my_snack_bar.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';
import 'package:waffaq_x/views/widgets/texts/no_results_found.dart';

class SetAdminPage extends StatefulWidget {
  const SetAdminPage({Key? key}) : super(key: key);

  @override
  State<SetAdminPage> createState() => _SetAdminPageState();
}

class _SetAdminPageState extends State<SetAdminPage> {
  final UsersController _usersController = UsersController();
  late bool abilityToAddCoverCompValue,
      abilityToRemoveCompValue,
      abilityToAddMobilesValue;
  @override
  Widget build(BuildContext context) {

    debugPrint('here rebuild');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            setNewAdminText,
            textDirection: TextDirection.rtl,
          ),
        ),
        body: Padding(
          padding: padding8,
          child: StreamBuilder<List<AdminModel>>(
            stream: _usersController.getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else {
                if (snapshot.data!.isEmpty) {
                  return const NoResultsFound();
                }
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {

                    AdminModel userModel = snapshot.data![index];
                    abilityToAddMobilesValue = userModel.abilityToAddMobiles;
                    abilityToAddCoverCompValue = userModel.abilityToAddCoverComp;
                    abilityToRemoveCompValue = userModel.abilityToRemoveComp;
                    return UserItemDesign(
                      name: userModel.name!,
                      email: userModel.email!,
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: const Text(
                                        setNewAdminText,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(userModel.name!),
                                          gap8,
                                          Text(userModel.email!),
                                          gap8,
                                          const SkinnyDivider(),
                                          gap16,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: const [
                                              Text(
                                                powersText,
                                              ),
                                            ],
                                          ),
// add mobiles permission
                                          CheckboxListTile(
                                            title: const Text(
                                              addMobilesText,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: abilityToAddMobilesValue,
                                            onChanged: (value) {
                                              setState(() {
                                                abilityToAddMobilesValue =
                                                    value!;
                                              });
                                            },
                                          ),
// add cover comp permission
                                          CheckboxListTile(
                                            title: const Text(
                                              addCoversCompatibilitiesText,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: abilityToAddCoverCompValue,
                                            onChanged: (value) {
                                              setState(() {
                                                abilityToAddCoverCompValue =
                                                    value!;
                                              });
                                            },
                                          ),
// delete cover comp permission
                                          CheckboxListTile(
                                            title: const Text(
                                              deleteCoversCompText,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: abilityToRemoveCompValue,
                                            onChanged: (value) {
                                              setState(() {
                                                abilityToRemoveCompValue =
                                                    value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
// cancel button
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            abilityToAddMobilesValue = userModel.abilityToAddMobiles;
                                            abilityToAddCoverCompValue = userModel.abilityToAddCoverComp;
                                            abilityToRemoveCompValue = userModel.abilityToRemoveComp;
                                          },
                                          child: const Text(
                                            cancelText,
                                            style: TextStyle(color: grayColor),
                                          ),
                                        ),
// set admin button
                                        BlocConsumer<AddDataCubit, AddDataState>(
                                          listener: (context, state) {
                                            if (state is FailedToAddData){
                                              showMySnackBar(context: context, content: 'error', color: redColor);
                                            }
                                            if (state is DataAddedSuccessfully){
                                              Navigator.pop(context);
                                            }
                                          },
                                          builder: (context, state){
                                            if (state is AddingData){
                                              return const SizedBox(
                                                height: size24,
                                                width: size24,
                                                child: Loading(),
                                              );
                                            }
                                            return TextButton(
                                              onPressed: () {
                                                userModel
                                                    .abilityToAddMobiles =
                                                    abilityToAddMobilesValue;
                                                userModel
                                                    .abilityToAddCoverComp =
                                                    abilityToAddCoverCompValue;
                                                userModel
                                                    .abilityToRemoveComp =
                                                    abilityToRemoveCompValue;
                                                BlocProvider.of<AddDataCubit>(
                                                    context)
                                                    .addData(
                                                    path:
                                                    '${FireStorePathes.usersPath}${userModel.uid}',
                                                    data: userModel
                                                        .toJson());
                                              },
                                              child: const Text(
                                                okText,
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  },
                                ));
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return gap8;
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
