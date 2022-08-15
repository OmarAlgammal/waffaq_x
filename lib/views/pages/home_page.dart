import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waffaq_x/models/admin_model.dart';
import 'package:waffaq_x/routes.dart';
import 'package:waffaq_x/services/auth_services.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/constantsIcons.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/constants/texts/paths.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/views/widgets/dividers/skinnyDivider.dart';
import 'package:waffaq_x/views/widgets/input/search_box.dart';
import 'package:waffaq_x/views/widgets/items_designs/brand_item_design.dart';
import 'package:waffaq_x/views/widgets/texts/helper_text.dart';
import 'package:waffaq_x/views/widgets/texts/loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, this.user}) : super(key: key);

  final User? user;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: whiteColor,
            statusBarIconBrightness: Brightness.dark),
        automaticallyImplyLeading: false,
        shadowColor: whiteColor,
        backgroundColor: whiteColor,
        toolbarHeight: size120,
        elevation: size0,
        centerTitle: true,
        title: SizedBox(
          child: SvgPicture.asset(appLogoPath),
        ),
        actions: [
// logout icon
          IconButton(onPressed: () async{
            await AuthServices().signOut();
          }, icon: const Icon(logoutIcon, color:  blackColor,)),

// more icon
          StreamBuilder<UserModel>(
            stream: FirestoreServices.instance.streamDoc(path: '$usersPath${user!.uid}', builder: (map) => UserModel.fromJson(map)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return const Loading();
              }
              else{
                final data = snapshot.data!;
                if (!data.abilityToRemoveComp && !data.abilityToAddCoverComp && !data.abilityToAddMobiles){
                  return const SizedBox();
                }
                return SizedBox(
                  width: size36,
                  child: IconButton(
                    icon: const Icon(
                      moreIcon,
                      color: blackColor,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: newGrayColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(size16),
                                  topRight: Radius.circular(size16))),
                          builder: (_) {
                            return Wrap(children: [
                              Padding(
                                padding: padding16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  textDirection: TextDirection.rtl,
                                  children: [
// add new mobile button
                                  if (snapshot.data!.abilityToAddMobiles)
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, AppRoutes.addMobilePage);
                                        },
                                        leading: const Icon(addIcon, color: blackColor,),
                                        title: const Text(
                                          addNewMobileText,
                                        ),),
                                    ),
                                    const SkinnyDivider(),
// add cover comp
                                  if (snapshot.data!.abilityToAddCoverComp)
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, AppRoutes.addCompPage);
                                        },
                                        leading: const Icon(addIcon, color: blackColor),
                                        title: const Text(
                                          addCoversCompatibilitiesText,
                                          style: TextStyle(
                                            fontSize: size16, color: blackColor,),
                                        ),
                                      ),
                                    ),
// compatibilities button
                                  if (snapshot.data!.abilityToRemoveComp)
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context,
                                              AppRoutes.coverCompPage);
                                        },
                                        child: const Text(
                                          coversCompatibilitiesText,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontSize: size16, color: blackColor),
                                        )),
                                    const SkinnyDivider(),
// set new admin button
                                  if (snapshot.data!.isHeTheMainController)
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, AppRoutes.setAdminPage);
                                      },
                                      child: const Text(
                                        setNewAdminText,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontSize: size16, color: blackColor),
                                      ),
                                    ),
                                    const SkinnyDivider(),

                                  ],
                                ),
                              ),
                            ]);
                          });
                    },
                  ),
                );

              }
            }
          ),
          gap16,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: size8, left: size8, top: size8),
        child: ListView(
          children: [
            const HelperText(helperText: searchForCompatibilitiesText),
            SearchBox(
              onPressed: () {
                Navigator.pushNamed(
                    context, AppRoutes.searchForCompPage);
              },
            ),
            gap16,
            const Align(
              alignment: Alignment.centerRight,
              child: Text(brandsText),
            ),
            gap8,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: padding0,
              itemCount: brandsLogosTextsList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    BrandItemDesign(
                        brandName: brandsNamesTextsList[index],
                        logoPath: brandsLogosTextsList[index],
                        brandColor: brandsColors[index]),
                    gap8,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
