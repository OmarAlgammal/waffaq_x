

import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/views/models/mobile_theme.dart';

abstract class BrandMobilesState{}

class BrandMobilesInitialState extends BrandMobilesState{}

class LoadingBrandMobiles extends BrandMobilesState{}

class BrandMobilesLoadedSuccessfully extends BrandMobilesState{
  final List<MobileTheme> mobilesTheme;
  BrandMobilesLoadedSuccessfully({required this.mobilesTheme});
}

class FailedToLoadBrandMobiles extends BrandMobilesState{}