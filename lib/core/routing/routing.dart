import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../service/navigation_service.dart';
import 'routes.dart';

final GoRouter routing = GoRouter(
  navigatorKey: navigator.navigatorKey,
  initialLocation: Routes.landing,
  routes: <RouteBase>[
   
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(),
    body: const Center(
      child: Text('Page not found'),
    ),
  ),
);
