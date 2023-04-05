

import '../../models/brand_theme_models/mobile_theme.dart';

abstract class ScreenCompState{}

class ScreenCompInitState extends ScreenCompState{}


class LoadingScreenComp extends ScreenCompState{}

class ScreenCompLoadedSuccessfully extends ScreenCompState{
  final List<MobileTheme> mobilesTheme;
  ScreenCompLoadedSuccessfully({required this.mobilesTheme});
}

class FailedToLoadScreenComp extends ScreenCompState{}