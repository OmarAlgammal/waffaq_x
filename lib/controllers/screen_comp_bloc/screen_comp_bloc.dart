import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/comp_event.dart';
import 'package:waffaq_x/controllers/screen_comp_bloc/screen_comp_state.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/utilities/helpers/mobiles_filtration_helper.dart';

import '../../models/brand_theme_models/mobile_theme.dart';

class ScreenCompBloc extends Bloc<CompEvent, ScreenCompState> {
  final FirestoreServices _fireStoreServices = FirestoreServices.instance;
  final MobilesFiltrationHelper _filtrationHelper = MobilesFiltrationHelper();

  ScreenCompBloc() : super(ScreenCompInitState()) {
    on<LoadScreenComp>(_screenComp);
  }

  Future<void> _screenComp(
      LoadScreenComp event, Emitter<ScreenCompState> emit) async {
    emit(LoadingScreenComp());
    try {
      final stream = _fireStoreServices.streamCollection(
          path: FireStorePathes.mobilesPath,
          builder: (map) => Mobile.fromJson(map),
          query: (query) {
            if (event.mobile.brandName == appleText) {
              query.where(FireStorePathes.brandNameParameter,
                  isEqualTo: appleText);
            } else {
              query.where(FireStorePathes.brandNameParameter,
                  isNotEqualTo: appleText);
            }
            return query;
          });

      await emit.forEach(stream, onData: (List<Mobile> mobiles) {
        List<MobileTheme> mobilesTheme = _filtrationHelper
            .getScreensCompatibilities(mobiles: mobiles, mobile: event.mobile);
        return ScreenCompLoadedSuccessfully(mobilesTheme: mobilesTheme);
      });
    } catch (e) {
      emit(FailedToLoadScreenComp());
    }
  }
}
