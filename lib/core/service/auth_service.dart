import 'dart:async';
import 'package:autoease/core/shared/enums.dart';
import 'package:autoease/core/shared/strings.dart';
import 'package:autoease/core/shared/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' show ScaffoldMessenger;
import '../shared/debug.dart';
import 'navigation_service.dart';

final authService = _AuthService.value;

class _AuthService {
  static _AuthService get value => _AuthService._();
  _AuthService._();

  final _instance = FirebaseAuth.instance;

  User? get user => _instance.currentUser;

  bool get isLoggedIn => user != null;

  Future<void> invoke<R>({
    required Future<R> Function(FirebaseAuth auth) onExecute,
    required Function(R)? onCompleted,
    bool isolatedAuth = false,
    Function? onError,
  }) async {
    try {
      FirebaseAuth? tempAuth;
      if (isolatedAuth) {
        final annonymous = await Firebase.initializeApp(
          name: "annonymous",
          options: Firebase.app().options,
        );
        tempAuth = FirebaseAuth.instanceFor(app: annonymous);
      }
      await onExecute(tempAuth ?? _instance)
          .then(onCompleted ?? (_) {}, onError: onError);
    } on FirebaseAuthException catch (error) {
      debug.print(error.message, tag: 'Auth Exception');
      ScaffoldMessenger.of(navigator.context).showSnackBar(
        style.snackbar(
          error.message ?? string.of().someErrorOccured,
          type: AlertType.error,
        ),
      );
      onError?.call();
    }
  }

  Future<void> signOut() async => await _instance.signOut();
}
