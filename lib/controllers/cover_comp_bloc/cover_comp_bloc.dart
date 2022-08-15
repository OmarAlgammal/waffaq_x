
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/comp_event.dart';
import 'package:waffaq_x/controllers/cover_comp_bloc/cover_comp_state.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/mobiles_filtration_helper.dart';
import 'package:waffaq_x/views/models/mobile_theme.dart';

class CoverCompBloc extends Bloc<CompEvent, CoverCompState>{
  CoverCompBloc() : super(CoverCompInitState()){
    on<LoadCoversComp>(_coverComp);
  }

  final FirestoreServices _fireStoreServices = FirestoreServices.instance;
  final MobilesFiltrationHelper _filtrationHelper = MobilesFiltrationHelper();



  Future<void> _coverComp(LoadCoversComp event, Emitter<CoverCompState> emit) async{
    emit(LoadingCoverComp());
    try{
      String mobileName = '${event.mobile.brandName} ${event.mobile.mobileName}';

      List<List<String>> compIds = await _fireStoreServices.collection(path: coversPath, builder: (map) {
        List<String> compIds = (map[compParameter] as List).cast<String>();
        return compIds;
      }, query: (query) => query.where(compParameter, arrayContains: mobileName));


      List<MobileTheme> comp = [];

      for (List<String> list in compIds){
        for(final id in list){
          if (id != mobileName){
            Mobile mobile =  await _fireStoreServices.doc(path: '$mobilesPath$id', builder: (map) {
              return Mobile.fromJson(map);
            });
            MobileTheme mobileTheme = _filtrationHelper.getMobileWithTheme(mobile);
            comp.add(mobileTheme);
          }
        }
      }
     emit(CoverCompLoadedSuccessfully(mobilesTheme: comp));

    }
    catch(e){
      emit(FailedToLoadCoverComp());
    }
  }

}