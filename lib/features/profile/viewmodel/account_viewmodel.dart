import 'package:flutter/material.dart';
import '../../../core/routing/routes.dart';
import '../../../core/shared/local_storage.dart';
import '../../auth/model/user_model.dart';

class AccountViewModel extends ChangeNotifier {
  final BuildContext context;

  AccountViewModel(this.context);

  User? _user = localStorage.user;
  set user(User? user) => {
        _user = user,
        notifyListeners(),
        localStorage.user = user,
      };
  User? get user => _user;

  logout() {
    user = null;
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
  }
}
