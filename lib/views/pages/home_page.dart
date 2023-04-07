import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waffaq_x/models/admin/admin_model.dart';
import 'package:waffaq_x/services/auth_services.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/constantsDimens.dart';
import 'package:waffaq_x/utilities/constants/constantsIcons.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/constants/texts/paths.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/views/widgets/buttons/list_tile.dart';
import 'package:waffaq_x/views/widgets/buttons/my_text_button.dart';
import 'package:waffaq_x/views/widgets/dividers/skinnyDivider.dart';
import 'package:waffaq_x/views/widgets/input/search_box_to_move.dart';
import 'package:waffaq_x/views/widgets/items_designs/brand_item_design.dart';
import 'package:waffaq_x/views/widgets/texts/helper_text.dart';

import '../../utilities/routing/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    AdminModel adminModel = AdminModel(
      uid: widget.user!.uid,
      email: widget.user!.email,
    );
    FirestoreServices.instance
        .setData(path: FireStorePathes.usersPath(widget.user!.uid), data: adminModel.toJson());
    super.initState();
  }

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
          IconButton(
              onPressed: () async {
                await AuthServices().signOut();
              },
              icon: const Icon(
                logoutIcon,
                color: blackColor,
              )),

// more icon
//           if (widget.user != null)
//             FutureBuilder<AdminModel>(
//               future: FirestoreServices.instance.document(
//                 path: FireStorePathes.usersPath(widget.user!.uid),
//                 builder: (map) => AdminModel.fromJson(map),
//               ),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const SizedBox();
//                 }
//                 if (!snapshot.hasData) {
//                   return const SizedBox();
//                 }
//                 final data = snapshot.data!;
//                 return _buildMoreButton(context, data);
//               },
//             ),
//           gap16,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: size8, left: size8, top: size8),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const HelperText(helperText: searchForCompatibilitiesText),
            SearchBoxToMove(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.searchForCompPage);
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

  _buildMoreButton(BuildContext context, AdminModel admin) {
    showModalBottomSheet(
        context: context,
        backgroundColor: newGrayColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size16),
                topRight: Radius.circular(size16))),
        builder: (_) {
          return Wrap(
            children: [
              if (admin.abilityToAddMobiles)
                MyListTile(
                  addNewMobileText,
                  addIcon,
                  () => Navigator.pushNamed(context, AppRoutes.addMobilePage),
                ),
              const SkinnyDivider(),
              if (admin.abilityToAddCoverComp)
                MyListTile(
                  addCoversCompatibilitiesText,
                  addIcon,
                  () => Navigator.pushNamed(context, AppRoutes.addCompPage),
                ),
              if (admin.abilityToRemoveComp)
                MyTextButton(
                  coversCompatibilitiesText,
                  () => Navigator.pushNamed(context, AppRoutes.coverCompPage),
                ),
              const SkinnyDivider(),
              if (admin.isHeTheMainController)
                MyTextButton(
                  setNewAdminText,
                  () => Navigator.pushNamed(context, AppRoutes.setAdminPage),
                ),
              const SkinnyDivider(),
            ],
          );
        });
  }
}
