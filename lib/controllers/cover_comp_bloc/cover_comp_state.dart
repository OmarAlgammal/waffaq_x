

import 'package:waffaq_x/views/models/mobile_theme.dart';

abstract class CoverCompState{}

class CoverCompInitState extends CoverCompState{}

class LoadingCoverComp extends CoverCompState{}

class CoverCompLoadedSuccessfully extends CoverCompState{
  final List<MobileTheme> mobilesTheme;
  CoverCompLoadedSuccessfully({required this.mobilesTheme});
}

class FailedToLoadCoverComp extends CoverCompState{}