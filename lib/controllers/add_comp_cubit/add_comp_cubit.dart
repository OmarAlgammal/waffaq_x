import 'package:bloc/bloc.dart';
import 'package:waffaq_x/controllers/add_comp_cubit/add_comp_state.dart';
import 'package:waffaq_x/models/mobile/mobile.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';

class AddCompCubit extends Cubit<AddCompState> {
  AddCompCubit() : super(AddCompInitState());

  final FirestoreServices _fireStoreServices = FirestoreServices.instance;

  Future<void> addComp(
      {required String path,
      required Mobile firstMobile,
      required Mobile secondMobile}) async {
    emit(AddingComp());
    try {
      String firstMobilePath =
          '$path${firstMobile.brandName} ${firstMobile.mobileName}';
      String secondMobilePath =
          '$path${secondMobile.brandName} ${secondMobile.mobileName}';

      String firstMobileName =
          '${firstMobile.brandName} ${firstMobile.mobileName}';
      String secondMobileName =
          '${secondMobile.brandName} ${secondMobile.mobileName}';

      List<List<String>> comps = await _fireStoreServices.collection(
          path: path,
          builder: (map) {
            List<String> compIds =
                (map[FireStorePathes.compParameter] as List).cast<String>();
            return compIds;
          },
          query: (query) => query.where(FireStorePathes.compParameter,
              arrayContainsAny: [firstMobileName, secondMobileName]));

      /// if there is more than one comp collection for these two mobiles
      /// it's mean than each mobile in separate comp collection
      /// which mean that i can't add two mobiles two the same comp collection
      if (comps.length >= 2) {
        return emit(EachMobileInSeparateGroup());
      }

      for (final list in comps) {
        for (String mobileName in list) {
          if (mobileName == firstMobileName) {
            if (list.contains(secondMobileName) == false) {
              return emit(CompAreAlreadyExist());
            }
            list.add(secondMobileName);
            await _fireStoreServices.setData(
                path: '$path${list[0]}',
                data: {FireStorePathes.compParameter: list});
            return emit(CompAddedSuccessfully());
          } else if (mobileName == secondMobileName) {
            if (list.contains(firstMobileName) == false) {
              return emit(CompAreAlreadyExist());
            }
            list.add(firstMobileName);
            await _fireStoreServices.setData(
                path: '$path${list[0]}',
                data: {FireStorePathes.compParameter: list});
            return emit(CompAddedSuccessfully());
          }
        }
      }

      List<String> list = [firstMobileName, secondMobileName];
      await _fireStoreServices.setData(
          path: firstMobilePath, data: {FireStorePathes.compParameter: list});
      emit(CompAddedSuccessfully());
    } catch (e) {
      return emit(FailedToAddComp());
    }
  }
}
