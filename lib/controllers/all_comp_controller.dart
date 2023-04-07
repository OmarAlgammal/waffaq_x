

import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';

class AllCompController{
  final FirestoreServices _fireStoreServices = FirestoreServices.instance;

  Stream<List<List<String>>> allCoversComp(){
    final stream = _fireStoreServices.streamCollection(path: FireStorePathes.coversPath, builder: (map){
      List<String> compIds = (map[FireStorePathes.compParameter] as List).cast<String>();
      return compIds;
    });

    return stream;
  }

}