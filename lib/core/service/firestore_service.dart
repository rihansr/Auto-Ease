import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/debug.dart';

final firestoreService = FirestoreService.value;

class FirestoreService {
  static FirestoreService get value => FirestoreService._();
  FirestoreService._();

  final _instance = FirebaseFirestore.instance;

  call(Future action, {Function()? onError}) async {
    try {
      await action.onError((error, stackTrace) {
        debug.print(error, tag: 'Firestore Exception');
        onError?.call();
      });
    } catch (error) {
      debug.print(error, tag: 'Firestore Exception');
      onError?.call();
    }
  }
}

extension FirestoreServiceExtension
    on CollectionReference<Map<String, dynamic>> {
  set({
    required String id,
    required Map<String, dynamic> data,
    Function()? callback,
  }) async =>
      doc(id).set(data).timeout(const Duration(seconds: 1)).onError(
        (error, stackTrace) {
          debug.print(error, tag: 'Add Exception');
        },
      ).then((_) => callback?.call());

  update({
    required String id,
    required Map<String, dynamic> data,
    Function()? callback,
  }) async =>
      doc(id).update(data).timeout(const Duration(seconds: 1)).onError(
        (error, stackTrace) {
          debug.print(error, tag: 'Update Exception');
        },
      ).then((_) => callback?.call());

  delete({
    required String id,
    Function()? callback,
  }) =>
      doc(id).delete().timeout(const Duration(seconds: 1)).onError(
        (error, stackTrace) {
          debug.print(error, tag: 'Delete Exception');
        },
      ).then((_) => callback?.call());
}
