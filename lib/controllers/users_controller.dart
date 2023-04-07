

import 'package:waffaq_x/models/admin/admin_model.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';

class UsersController{

  Stream<List<AdminModel>> getAllUsers() {
    return FirestoreServices.instance.streamCollection(path: FireStorePathes.usersPath(''), builder: (map) => AdminModel.fromJson(map));
  }
}