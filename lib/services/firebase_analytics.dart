import 'package:firebase_analytics/firebase_analytics.dart';

// final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

class AnalyticsServices {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> logLoginEvent(String email) async {
    await _analytics.logEvent(
      name: 'login',
      parameters: <String, dynamic>{
        'method': 'email',
        'email': email,
      },
    );
  }
}
