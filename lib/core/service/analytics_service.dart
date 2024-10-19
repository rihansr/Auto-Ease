import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

final AnalyticsService analyticsService = AnalyticsService.value;

class AnalyticsService {
  static AnalyticsService get value => AnalyticsService._();
  AnalyticsService._();

  final _instance = FirebaseAnalytics.instance;

  Future<void> init() => _instance.logAppOpen();

  Future<void> logUser(String? userId) async {
    if (kReleaseMode) {
      await _instance.setUserId(id: userId);
    }
  }

  Future<void> logRegister() async{
    if (kReleaseMode) {
      await _instance.logSignUp(signUpMethod: 'sign_up');
    }
  }

  Future<void> logLogin() async{
    if (kReleaseMode) {
      await _instance.logLogin(loginMethod: 'login');
    }
  }
}
