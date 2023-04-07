

import '../../models/brand_theme_models/mobile_theme.dart';

abstract class BrandMobilesState{}

class BrandMobilesInitialState extends BrandMobilesState{}

class BrandMobilesLoading extends BrandMobilesState{}

class BrandMobilesLoadedSuccessfully extends BrandMobilesState{
  final List<MobileTheme> mobilesTheme;
  BrandMobilesLoadedSuccessfully({required this.mobilesTheme});
}

class FailedToLoadBrandMobiles extends BrandMobilesState{}