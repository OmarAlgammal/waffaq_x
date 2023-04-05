

import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';
import 'package:waffaq_x/utilities/constants/texts/texts.dart';
import 'package:waffaq_x/utilities/helpers/mobiles_filtration_helper.dart';

class CompController {
  final FirestoreServices _fireStoreServices = FirestoreServices.instance;
  final MobilesFiltrationHelper _filtrationHelper = MobilesFiltrationHelper();

  Stream<List<List<String>>> allCoverCompController(){
    return _fireStoreServices.streamCollection(path: coversPath, builder: (map){
      List<String> ids = (map[compParameter]) as List<String>;
      return ids;
    });
  }


}