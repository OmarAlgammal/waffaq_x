
import 'package:bloc/bloc.dart';
import 'package:waffaq_x/controllers/delete_data_cubit/delete_data_state.dart';
import 'package:waffaq_x/services/firestore_services.dart';

class DeleteDataCubit extends Cubit<DeleteDataState>{
  DeleteDataCubit() : super(DeleteDataInitState());

  final FirestoreServices _fireStoreServices = FirestoreServices.instance;

  Future<void> deleteData({required String path}) async{
    emit(DeletingData());
    try{
      await _fireStoreServices.deleteData(path: path);
      emit(DataDeletedSuccessfully());
    }
    catch(e){
      emit(FailedToDeleteData());
    }
  }


}