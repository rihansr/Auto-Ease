import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/routes.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/service/firestore_service.dart';
import '../../../core/service/navigation_service.dart';
import '../../../core/shared/local_storage.dart';
import '../../auth/model/user_model.dart';

class AccountViewModel extends ChangeNotifier {
  AccountViewModel();

  User? _user = localStorage.user;
  set user(User? user) => {
        _user = user,
        notifyListeners(),
        localStorage.user = user,
      };
  User? get user => _user;

  userinfo() {
    firestoreService.invoke(
      onExecute: (firestore) async =>
          firestore.collection('users').doc(authService.user?.uid).get(),
      onCompleted: (snapshot) => user = User.fromMap(snapshot.data()!),
    );
  }

  logout() {
    user = null;
    authService.signOut();
    navigator.context.pushReplacementNamed(Routes.login);
  }
}
