import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/routes.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/service/firestore_service.dart';
import '../../../core/service/navigation_service.dart';
import '../../../core/shared/local_storage.dart';
import '../../../core/shared/strings.dart';
import '../../../core/widget/modal_bottomsheet.dart';
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

  logout() => ModalBottomSheet.show(
        navigator.context,
        (context) => ModalBottomSheet(
          title: Text(
            string.of(context).logout,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            string.of(context).wantToLogout,
            textAlign: TextAlign.center,
          ),
          primaryButtonLabel: string.of(context).logout,
          primaryButtonColor: Theme.of(context).colorScheme.tertiary,
          onPrimaryButtonPressed: () {
            user = null;
            authService.signOut();
            navigator.context.pushReplacementNamed(Routes.login);
          },
        ),
      );
}
