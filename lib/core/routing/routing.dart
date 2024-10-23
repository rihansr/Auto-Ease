import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/account/view/account_update_view.dart';
import '../../features/auth/view/login_view.dart';
import '../../features/auth/view/register_view.dart';
import '../../features/home/view/home_view.dart';
import '../../features/splash/view/splash_view.dart';
import '../service/navigation_service.dart';
import 'routes.dart';

final GoRouter routing = GoRouter(
  navigatorKey: navigator.navigatorKey,
  initialLocation: Routes.splash,
  routes: <RouteBase>[
    GoRoute(
      name: Routes.splash,
      path: Routes.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      name: Routes.login,
      path: Routes.login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
    GoRoute(
      name: Routes.register,
      path: Routes.register,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterView();
      },
    ),
    GoRoute(
      name: Routes.update,
      path: Routes.update,
      builder: (BuildContext context, GoRouterState state) {
        return const AccountUpdateView();
      },
    ),
    GoRoute(
      name: Routes.home,
      path: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(),
    body: const Center(
      child: Text('Page not found'),
    ),
  ),
);
