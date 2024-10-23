import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/routing/routes.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/service/firestore_service.dart';
import '../../../core/service/navigation_service.dart';
import '../../../core/shared/local_storage.dart';
import '../../../core/shared/strings.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/modal_bottomsheet.dart';
import '../../auth/model/user_model.dart';
import '../../booking/viewmodel/bookings_viewmodel.dart';

class AccountViewModel extends ChangeNotifier {
  AccountViewModel();

  User? _user = localStorage.user;
  set user(User? user) => {
        _user = user,
        notifyListeners(),
        localStorage.user = _user,
      };
  User? get user => _user;

  Future<void> userinfo() async {
    await firestoreService.invoke(
      onExecute: (firestore) async =>
          await firestore.collection('users').doc(authService.user?.uid).get(),
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
          actions: [
            Button(
              label: string.of(context).logout,
              margin: const EdgeInsets.all(0),
              background: Theme.of(context).colorScheme.tertiary,
              onPressed: () => authService.signOut().then(
                (_) {
                  user = null;
                  Navigator.pop(context);
                  context.read<BookingsViewModel>().reset();
                  navigator.context.pushReplacementNamed(Routes.login);
                },
              ),
            ),
            Button(
              label: string.of(context).cancel,
              background: Colors.transparent,
              fontColor: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
}
