
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waffaq_x/controllers/add_data_cubit/add_data_state.dart';
import 'package:waffaq_x/services/firestore_services.dart';

class AddDataCubit extends Cubit<AddDataState>{
  AddDataCubit() : super(AddDataInitState());

  final FirestoreServices _fireStoreServices = FirestoreServices.instance;

  Future<void> addData({required String path, required Map<String, dynamic> data}) async{
    emit(AddingData());
    try{
      await _fireStoreServices.setData(path: path, data: data);
      emit(DataAddedSuccessfully());
    }catch(e){
      emit(FailedToAddData());
    }
  }

}