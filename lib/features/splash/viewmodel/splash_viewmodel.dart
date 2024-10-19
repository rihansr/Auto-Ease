import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/routes.dart';
import '../../../core/shared/constants.dart';
import '../../../core/shared/local_storage.dart';

class SplashViewModel extends ChangeNotifier {
  final BuildContext context;

  SplashViewModel(this.context);

  late Timer _timer;

  init() async {
    _timer = Timer(kSplashTimeout, _navigateTo);
  }

  _navigateTo() => context.pushReplacementNamed(
        localStorage.isLoggedIn ? Routes.landing : Routes.login,
      );

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
