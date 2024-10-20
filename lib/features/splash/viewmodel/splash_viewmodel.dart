import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/routes.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/shared/constants.dart';

class SplashViewModel extends ChangeNotifier {
  final BuildContext context;

  SplashViewModel(this.context);

  late Timer _timer;

  init() async {
    _timer = Timer(kSplashTimeout, _navigateTo);
  }

  _navigateTo() => context.pushReplacementNamed(
        authService.isLoggedIn ? Routes.home : Routes.login,
      );

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
