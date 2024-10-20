import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show ScaffoldMessenger;
import '../shared/debug.dart';
import '../shared/enums.dart';
import '../shared/styles.dart';
import 'navigation_service.dart';

final firestoreService = FirestoreService.value;

class FirestoreService {
  static FirestoreService get value => FirestoreService._();
  FirestoreService._();

  final _instance = FirebaseFirestore.instance;

  Future<void> invoke<R>({
    required Future<R> Function(FirebaseFirestore firestore) onExecute,
    Function(R)? onCompleted,
    Function? onError,
  }) async {
    try {
      await onExecute(_instance).then(onCompleted ?? (_) {}, onError: onError);
    } catch (error) {
      debug.print(error, tag: 'Firestore Exception');
      ScaffoldMessenger.of(navigator.context).showSnackBar(
        style.snackbar(error.toString(), type: AlertType.error),
      );
      onError?.call();
    }
  }
}

extension FirestoreServiceExtension
    on CollectionReference<Map<String, dynamic>> {
  set({
    required String id,
    required Map<String, dynamic> data,
  }) async =>
      doc(id).set(data).timeout(const Duration(seconds: 1)).onError(
        (error, stackTrace) {
          debug.print(error, tag: 'Add Exception');
        },
      );

  update({
    required String id,
    required Map<String, dynamic> data,
    Function()? callback,
  }) async =>
      doc(id).update(data).timeout(const Duration(seconds: 1)).onError(
        (error, stackTrace) {
          debug.print(error, tag: 'Update Exception');
        },
      );

  delete({
    required String id,
    Function()? callback,
  }) =>
      doc(id).delete().timeout(const Duration(seconds: 1)).onError(
        (error, stackTrace) {
          debug.print(error, tag: 'Delete Exception');
        },
      );
}
