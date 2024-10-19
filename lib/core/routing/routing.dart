import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/view/login_view.dart';
import '../../features/auth/view/register_view.dart';
import '../../features/dashboard/view/dashboard_view.dart';
import '../service/navigation_service.dart';
import '../shared/local_storage.dart';
import 'routes.dart';

final GoRouter routing = GoRouter(
  navigatorKey: navigator.navigatorKey,
  initialLocation:
      '/${localStorage.isLoggedIn ? localStorage.user!.uid : Routes.login}',
  routes: <RouteBase>[
    GoRoute(
      name: Routes.login,
      path: '/${Routes.login}',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
    GoRoute(
      name: Routes.register,
      path: '/${Routes.register}',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterView();
      },
    ),
    GoRoute(
      name: Routes.landing,
      path: '/:uid',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardView();
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
