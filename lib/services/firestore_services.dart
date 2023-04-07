import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  FirestoreServices._();

  static FirestoreServices instance = FirestoreServices._();

  Stream<List<T>> streamCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> map) builder,
    Query Function(Query query)? query,
  }) {
    Query collection = _fireStore.collection(path);
    if (query != null) {
      collection = query(collection);
    }

    final snapshot = collection.snapshots();
    final result = snapshot.map((event) => event.docs
        .map((e) => builder(e.data() as Map<String, dynamic>))
        .where((element) => element != null)
        .toList());
    return result;
  }

  Future<List<T>> collection<T>({
    required String path,
    required T Function(Map<String, dynamic> map) builder,
    Query Function(Query query)? query,
  }) async {
    Query myQuery = _fireStore.collection(path);
    if (query != null) {
      myQuery = query(myQuery);
    }
    final collection = await myQuery.get();
    final result = collection.docs
        .map((e) => builder(e.data() as Map<String, dynamic>))
        .where((element) => element != null)
        .toList();
    return result;
  }

  Stream<T> documentStream<T>(
      {required String path,
      required T Function(Map<String, dynamic> map) builder}) {
    return _fireStore
        .doc(path)
        .snapshots()
        .map((event) => builder(event.data()!));
  }

  Future<T> document<T>(
      {required String path,
      required T Function(Map<String, dynamic> map) builder}) async {
    final result = await _fireStore.doc(path).get();
    return builder(result.data() as Map<String, dynamic>);
  }

  Future<void> setData(
      {required String path, required Map<String, dynamic> data}) async {
    //return await _fireStore.doc(path).set(data);
    return await FirebaseFirestore.instance.doc(path).set(data);
  }



  Future<void> deleteData({
    required String path,
  }) async {
    await _fireStore.doc(path).delete();
  }
}
