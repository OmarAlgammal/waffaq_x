import '../../models/brand_theme_models/mobile_theme.dart';

abstract class AllMobilesState {}

class AllMobilesInitState extends AllMobilesState {}

class LoadingAllMobiles extends AllMobilesState {}

class MobilesLoadedSuccessfully extends AllMobilesState {
  final List<MobileTheme> mobilesTheme;

  MobilesLoadedSuccessfully({required this.mobilesTheme});
}

class FailedToLoadMobiles extends AllMobilesState {}
