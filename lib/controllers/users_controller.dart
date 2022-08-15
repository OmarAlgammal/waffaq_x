

import 'package:waffaq_x/models/admin_model.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';

class UsersController{

  Stream<List<UserModel>> getAllUsers() {
    return FirestoreServices.instance.streamCollection(path: usersPath, builder: (map) => UserModel.fromJson(map));
  }
}