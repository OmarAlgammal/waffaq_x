import 'package:waffaq_x/controllers/cover_comp_bloc/cover_comp_state.dart';

import '../../models/brand_theme_models/mobile_theme.dart';

abstract class GlassCompState {}

class GlassCompInitState extends GlassCompState {}

class LoadingGlassComp extends GlassCompState {}

class GlassCompLoadedSuccessfully extends GlassCompState {
  final List<MobileTheme> mobilesTheme;

  GlassCompLoadedSuccessfully({required this.mobilesTheme});
}

class FailedToLoadGlassComp extends GlassCompState {}
