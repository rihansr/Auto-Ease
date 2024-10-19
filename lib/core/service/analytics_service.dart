import 'package:firebase_analytics/firebase_analytics.dart';

final AnalyticsService analyticsService = AnalyticsService.value;

class AnalyticsService {
  static AnalyticsService get value => AnalyticsService._();
  AnalyticsService._();

  final _instance = FirebaseAnalytics.instance;

  Future<void> init() => _instance.logAppOpen();

  Future<void> setUser(String? userId) async =>
      await _instance.setUserId(id: userId);
}
