import 'package:flutter/material.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/utilities/constants/constantsColors.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';

import '../../models/brand_theme_models/brand_theme.dart';
import '../../models/brand_theme_models/mobile_theme.dart';

class MobilesFiltrationHelper {
  final double biggestPossibleDifferenceBetweenDisplaysInScreens = .1;
  final double biggestPossibleDifferenceBetweenDisplaysInGlass = .03;

  List<MobileTheme> searchResult({
    required List<MobileTheme> mobileTheme,
    required String searchText,
  }) {
    List<MobileTheme> filteredList = [];
    for (int i = 0; i < mobileTheme.length; i++) {
      Mobile mobile = mobileTheme[i].mobile;
      String mobileWithBrandName =
          '${mobile.brandName.toLowerCase()} ${mobile.mobileName.toLowerCase()}';
      if (mobileWithBrandName.contains(searchText.toLowerCase())) {
        filteredList.add(mobileTheme[i]);
      }
    }
    return filteredList;
  }

  List<MobileTheme> getSearchResultWithTheme(
      {required List<Mobile> mobiles, required String searchText}) {
    List<MobileTheme> mobileTheme = getMobilesWithTheme(mobiles: mobiles);
    List<MobileTheme> filteredList = [];
    for (int i = 0; i < mobileTheme.length; i++) {
      Mobile mobile = mobileTheme[i].mobile;
      String mobileWithBrandName =
          '${mobile.brandName.toLowerCase()} ${mobile.mobileName.toLowerCase()}';
      if (mobileWithBrandName.contains(searchText.toLowerCase())) {
        filteredList.add(mobileTheme[i]);
      }
    }
    return filteredList;
  }

  List<BrandTheme> getIdsWithTheme({required List<String> ids}) {
    List<BrandTheme> idsThemes = [];
    for (String id in ids) {
      String brandName = id.split(' ').toList()[0];
      String mobileName = id.split(' ').toList()[1];
      idsThemes
          .add(getIdWithTheme(mobileName: mobileName, brandName: brandName));
    }
    return idsThemes;
  }

  List<MobileTheme> getMobilesArrangementWithTheme(List<dynamic> mobiles) {
    List<Mobile> myMobiles = [];
    if (mobiles is List<MobileTheme>) {
      for (final mobile in mobiles) {
        myMobiles.add(mobile.mobile);
      }
      mobiles = myMobiles;
    }

    List<MobileTheme> list = [];
    for (int i = 0; i < brandsNamesTextsList.length; i++) {
      String requiredBrandName = brandsNamesTextsList[i];
      for (Mobile mobile in mobiles) {
        String comingBrandName = mobile.brandName;
        if (requiredBrandName == comingBrandName) {
          list.add(getMobileWithTheme(mobile));
        }
      }
    }

    return list;
  }

  List<MobileTheme> getMobilesWithTheme({required List<Mobile> mobiles}) {
    List<MobileTheme> myList = [];
    for (Mobile mobile in mobiles) {
      myList.add(getMobileWithTheme(mobile));
    }
    return myList;
  }

  BrandTheme getIdWithTheme(
      {required String mobileName, required String brandName}) {
    debugPrint('brand name : $brandName');
    switch (brandName.toLowerCase()) {
      case 'apple':
        return BrandTheme(
            mobileName: mobileName,
            brandLogo: appleLogoText,
            brandColor: appleColor);
      case 'samsung':
        return BrandTheme(
            mobileName: mobileName,
            brandLogo: samsungLogoText,
            brandColor: samsungColor);
      case 'huawei':
        return BrandTheme(
            mobileName: mobileName,
            brandLogo: huaweiLogoText,
            brandColor: huaweiColor);
      case 'oppo':
        return BrandTheme(
            mobileName: mobileName,
            brandLogo: oppoLogoText,
            brandColor: oppoColor);
      case 'honor':
        return BrandTheme(
            mobileName: mobileName,
            brandLogo: honorLogoText,
            brandColor: honorColor);
      case 'vivo':
        return BrandTheme(
            mobileName: mobileName,
            brandLogo: vivoLogoText,
            brandColor: vivoColor);
      case 'xiaomi':
        return BrandTheme(
            mobileName: mobileName,
            brandLogo: xiaomiLogoText,
            brandColor: xiaomiColor);
      case 'realme':
        return BrandTheme(
            mobileName: mobileName,
            brandLogo: realmeLogoText,
            brandColor: realmeColor);
      case 'infinix':
        return BrandTheme(
            mobileName: mobileName,
            brandLogo: infinixLogoText,
            brandColor: infinixColor);
    }
    return BrandTheme(
        mobileName: mobileName,
        brandLogo: nokiaLogoText,
        brandColor: nokiaColor);
  }

  MobileTheme getMobileWithTheme(Mobile mobile) {
    switch (mobile.brandName.toLowerCase()) {
      case 'apple':
        return MobileTheme(
            mobile: mobile, brandLogo: appleLogoText, brandColor: appleColor);
      case 'samsung':
        return MobileTheme(
            mobile: mobile,
            brandLogo: samsungLogoText,
            brandColor: samsungColor);
      case 'huawei':
        return MobileTheme(
            mobile: mobile, brandLogo: huaweiLogoText, brandColor: huaweiColor);
      case 'oppo':
        return MobileTheme(
            mobile: mobile, brandLogo: oppoLogoText, brandColor: oppoColor);
      case 'honor':
        return MobileTheme(
            mobile: mobile, brandLogo: honorLogoText, brandColor: honorColor);
      case 'vivo':
        return MobileTheme(
            mobile: mobile, brandLogo: vivoLogoText, brandColor: vivoColor);
      case 'xiaomi':
        return MobileTheme(
            mobile: mobile, brandLogo: xiaomiLogoText, brandColor: xiaomiColor);
      case 'realme':
        return MobileTheme(
            mobile: mobile, brandLogo: realmeLogoText, brandColor: realmeColor);
      case 'infinix':
        return MobileTheme(
            mobile: mobile,
            brandLogo: infinixLogoText,
            brandColor: infinixColor);
    }
    return MobileTheme(
        mobile: mobile, brandLogo: nokiaLogoText, brandColor: nokiaColor);
  }

  List<MobileTheme> getBrandMobilesWithTheme(
      {required List<Mobile> mobiles, required String brandName}) {
    List<MobileTheme> list = [];
    List<Mobile> brandMobiles =
        getBrandMobiles(mobiles: mobiles, brandName: brandName);
    for (Mobile mobile in brandMobiles) {
      list.add(getMobileWithTheme(mobile));
    }
    return list;
  }

  List<Mobile> getBrandMobiles(
      {required List<Mobile> mobiles, required String brandName}) {
    List<Mobile> brandList = [];
    for (int i = 0; i < mobiles.length; i++) {
      if (mobiles[i]
          .brandName
          .toLowerCase()
          .contains(brandName.toLowerCase())) {
        if (!brandList.contains(mobiles[i])) {
          brandList.add(mobiles[i]);
        }
      }
    }
    return brandList;
  }

  List<MobileTheme> getScreensCompatibilities(
      {required List<Mobile> mobiles, required Mobile mobile}) {
    return getCompatibilities(
        mobiles: mobiles,
        mobile: mobile,
        biggestDifferenceBetweenScreenSizes:
            biggestPossibleDifferenceBetweenDisplaysInScreens);
  }

  List<MobileTheme> getGlassCompatibilities(
      {required List<Mobile> mobiles, required Mobile mobile}) {
    return getCompatibilities(
        mobiles: mobiles,
        mobile: mobile,
        biggestDifferenceBetweenScreenSizes:
            biggestPossibleDifferenceBetweenDisplaysInGlass);
  }

  List<MobileTheme> getDisplaysCompatibilities(
      {required List<Mobile> mobiles, required Mobile mobile}) {
    return getCompatibilities(
        mobiles: mobiles,
        mobile: mobile,
        biggestDifferenceBetweenScreenSizes:
            biggestPossibleDifferenceBetweenDisplaysInGlass);
  }

  List<MobileTheme> getCompatibilities(
      {required List<Mobile> mobiles,
      required Mobile mobile,
      required double biggestDifferenceBetweenScreenSizes}) {
    String requiredBrandName = mobile.brandName.toLowerCase();
    String requiredMobileName = mobile.mobileName.toLowerCase();
    bool requiredMobileNotch = mobile.hasNotch;
    bool requiredCurvedDisplay = mobile.curvedDisplay;

    List<MobileTheme> filteredList = [];

    // check if required mobile is from Apple brand
    if (requiredBrandName == appleText.toLowerCase()) {
      for (int mobileModelIndex = 0;
          mobiles.length > mobileModelIndex;
          mobileModelIndex++) {
        Mobile comingModel = mobiles[mobileModelIndex];
        String comingBrand = mobiles[mobileModelIndex].brandName.toLowerCase();
        String comingMobileName =
            mobiles[mobileModelIndex].mobileName.toLowerCase();

        if (comingBrand == requiredBrandName &&
            comingModel.displaySize == mobile.displaySize &&
            comingModel.curvedDisplay == requiredCurvedDisplay &&
            requiredMobileName != comingMobileName) {
          filteredList.add(getMobileWithTheme(comingModel));
        }
      }
    }
    // else required mobile is from other brand other than Apple
    else {
      // first filter mobiles list by brands order in list
      for (int brandNameIndex = 0;
          brandsNamesTextsList.length > brandNameIndex;
          brandNameIndex++) {
        String brandName = brandsNamesTextsList[brandNameIndex].toLowerCase();
        // then filter mobiles by screen sizes
        for (int mobileModelIndex = 0;
            mobiles.length > mobileModelIndex;
            mobileModelIndex++) {
          String comingBrandName =
              mobiles[mobileModelIndex].brandName.toLowerCase();
          String comingMobileName =
              mobiles[mobileModelIndex].mobileName.toLowerCase();
          Mobile comingMobile = mobiles[mobileModelIndex];
          bool comingCurvedScreen = comingMobile.curvedDisplay;
          bool comingNotch = comingMobile.hasNotch;
          double differenceBetweenTwoScreenSizes = double.parse(
              (comingMobile.displaySize - mobile.displaySize)
                  .abs()
                  .toStringAsFixed(2));

          if (brandName == comingBrandName &&
              comingBrandName != appleText.toLowerCase() &&
              requiredMobileName != comingMobileName &&
              requiredMobileNotch == comingNotch &&
              comingCurvedScreen == requiredCurvedDisplay &&
              differenceBetweenTwoScreenSizes <=
                  biggestDifferenceBetweenScreenSizes) {
            filteredList.add(getMobileWithTheme(comingMobile));
          }
        }
      }
    }

    return filteredList;
  }
}
