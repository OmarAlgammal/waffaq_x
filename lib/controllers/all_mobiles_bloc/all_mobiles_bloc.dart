import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/all_mobiles_bloc/all_mobiles_event.dart';
import 'package:waffaq_x/controllers/all_mobiles_bloc/all_mobiles_state.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/helpers/mobiles_filtration_helper.dart';

import '../../models/brand_theme_models/mobile_theme.dart';

class AllMobilesBloc extends Bloc<LoadAllMobilesEvent, AllMobilesState> {
  AllMobilesBloc() : super(AllMobilesInitState()) {
    on<LoadAllMobilesEvent>(_loadAllMobiles);
  }

  final FirestoreServices _firebaseFirestore = FirestoreServices.instance;
  final MobilesFiltrationHelper _filtrationHelper = MobilesFiltrationHelper();

  void _loadAllMobiles(
      LoadAllMobilesEvent event, Emitter<AllMobilesState> emit) async {
    emit(LoadingAllMobiles());
    try {
      final stream = _firebaseFirestore.streamCollection(
          path: mobilesPath,
          builder: (map) {
            return Mobile.fromJson(map);
          });
      await emit.forEach<List<Mobile>>(stream, onData: (List<Mobile> data) {
        List<MobileTheme> mobilesTheme =
            _filtrationHelper.getMobilesWithTheme(mobiles: data);
        return MobilesLoadedSuccessfully(mobilesTheme: mobilesTheme);
      });
    } catch (e) {
      emit(FailedToLoadMobiles());
    }
  }
}
