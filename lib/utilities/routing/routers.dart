import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:waffaq_x/utilities/routing/routes.dart';
import 'package:waffaq_x/views/pages/add_comp_page.dart';
import 'package:waffaq_x/views/pages/add_mobile_page.dart';
import 'package:waffaq_x/views/pages/brand_page.dart';
import 'package:waffaq_x/views/pages/comp_page.dart';
import 'package:waffaq_x/views/pages/cover_comp_page.dart';
import 'package:waffaq_x/views/pages/home_page.dart';
import 'package:waffaq_x/views/pages/landing_page.dart';
import 'package:waffaq_x/views/pages/login_page.dart';
import 'package:waffaq_x/views/pages/mobile_page.dart';
import 'package:waffaq_x/views/pages/search_for_comp_page.dart';
import 'package:waffaq_x/views/pages/select_mobile_page.dart';
import 'package:waffaq_x/views/pages/set_admin_page.dart';


Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {

    case AppRoutes.loginPage:
      return CupertinoPageRoute(
        builder: (_) => LoginPage(),
        settings: settings,
      );

    case AppRoutes.setAdminPage:
      return CupertinoPageRoute(
        builder: (_) => SetAdminPage(),
        settings: settings,
      );

    case AppRoutes.homePage:
      return CupertinoPageRoute(
        builder: (_) => const HomePage(),
        settings: settings,
      );

    case AppRoutes.compatibilitiesPage:
      return CupertinoPageRoute(
        builder: (_) => CompatibilitiesPage(),
        settings: settings,
      );

    case AppRoutes.coverCompPage:
      return CupertinoPageRoute(
        builder: (_) => CoverCompPage(),
        settings: settings,
      );


    case AppRoutes.selectMobilePage:
      return CupertinoPageRoute(
        builder: (_) => SelectMobilePage(),
        settings: settings,
      );

    case AppRoutes.addCompPage:
      return CupertinoPageRoute(
        builder: (_) => AddCompPage(),
        settings: settings,
      );

    case AppRoutes.addMobilePage:
      return CupertinoPageRoute(
        builder: (_) => AddMobilePage(),
        settings: settings,
      );

    case AppRoutes.brandPage:
      return CupertinoPageRoute(
        builder: (_) => BrandPage(),
        settings: settings,
      );

    case AppRoutes.searchForCompPage:
      return CupertinoPageRoute(
        builder: (_) => SearchForCompPage(),
        settings: settings,
      );

    case AppRoutes.mobilePage:
      return CupertinoPageRoute(
        builder: (_) => MobilePage(),
        settings: settings,
      );

    case AppRoutes.landingPage:
    default:
      return CupertinoPageRoute(
        builder: (_) => LandingPage(),
        settings: settings,
      );


  }
}
