import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/brand_mobiles_bloc/brand_mobiles_event.dart';
import 'package:waffaq_x/controllers/brand_mobiles_bloc/brand_mobiles_state.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/helpers/mobiles_filtration_helper.dart';

class BrandMobilesBloc extends Bloc<BrandMobilesEvent, BrandMobilesState> {
  final FirestoreServices _fireStoreServices = FirestoreServices.instance;
  final MobilesFiltrationHelper _filterationHelper = MobilesFiltrationHelper();

  BrandMobilesBloc() : super(BrandMobilesInitialState()) {
    on<LoadBrandMobiles>(_brandMobiles);
  }

  void _brandMobiles(
      LoadBrandMobiles event, Emitter<BrandMobilesState> emit) async {
    emit(BrandMobilesLoading());
    try {
      final stream = _fireStoreServices.streamCollection(
          path: FireStorePathes.mobilesPath,
          builder: (map) {
            return Mobile.fromJson(map);
          },
          query: (query) {
            return query.where(FireStorePathes.brandNameParameter,
                isEqualTo: event.brandName);
          });
      await emit.forEach<List<Mobile>>(stream, onData: (List<Mobile> mobiles) {
        final mobilesTheme = _filterationHelper.getBrandMobilesWithTheme(
            mobiles: mobiles, brandName: event.brandName);
        return BrandMobilesLoadedSuccessfully(mobilesTheme: mobilesTheme);
      });
    } catch (e) {
      emit(FailedToLoadBrandMobiles());
    }
  }
}
