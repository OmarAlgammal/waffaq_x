import 'package:bloc/bloc.dart';
import 'package:waffaq_x/controllers/comp_event.dart';
import 'package:waffaq_x/controllers/glass_comp_bloc/glass_comp_state.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/utilities/helpers/mobiles_filtration_helper.dart';

import '../../models/brand_theme_models/mobile_theme.dart';

class GlassCompBloc extends Bloc<CompEvent, GlassCompState> {
  final FirestoreServices _fireStoreServices = FirestoreServices.instance;
  final MobilesFiltrationHelper _filterationHelper = MobilesFiltrationHelper();

  GlassCompBloc() : super(GlassCompInitState()) {
    on<LoadGlassComp>(_glassComp);
  }

  Future<void> _glassComp(
      LoadGlassComp event, Emitter<GlassCompState> emit) async {
    emit(LoadingGlassComp());

    try {
      final stream = _fireStoreServices.streamCollection(
          path: FireStorePathes.mobilesPath,
          builder: (map) => Mobile.fromJson(map),
          query: (query) {
            if (event.mobile.brandName == appleText) {
              query.where(FireStorePathes.brandNameParameter, isEqualTo: appleText);
            } else {
              query.where(FireStorePathes.brandNameParameter, isNotEqualTo: appleText);
            }
            return query;
          });

      await emit.forEach<List<Mobile>>(stream, onData: (List<Mobile> mobiles) {
        List<MobileTheme> mobilesTheme = _filterationHelper
            .getGlassCompatibilities(mobiles: mobiles, mobile: event.mobile);
        return GlassCompLoadedSuccessfully(mobilesTheme: mobilesTheme);
      });
    } catch (e) {
      emit(FailedToLoadGlassComp());
    }
  }
}
