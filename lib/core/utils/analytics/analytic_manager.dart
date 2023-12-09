import 'package:cashback/core/extension/enum_extension.dart';
import 'package:cashback/core/extension/string_extension.dart';
import 'package:cashback/core/providers/firebase_providers.dart';
import 'package:cashback/core/utils/analytics/analytic_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final analyticsManagerProvider = Provider.autoDispose<AnalyticsManager>((ref) {
  final firebaseAnalytics = ref.watch(firebaseAnalyticsProvider);
  return AnalyticsManager(firebaseAnalytics);
});

class AnalyticsManager {
  final FirebaseAnalytics _firebaseAnalytics;

  AnalyticsManager(this._firebaseAnalytics);

  void logEventToFirebase(AnalyticsEvent analyticEvent, {Map<AnalyticsParameter, Object>? parameters}) {
    final sneakCaseParameters = parameters?.map((key, value) {
      if (value is String) {
        return MapEntry(key.toSnakeCase(), value.toSnakeCase());
      } else if (value is Enum) {
        return MapEntry(key.toSnakeCase(), value.toSnakeCase());
      } else {
        return MapEntry(key.toSnakeCase(), value);
      }
    });
    _firebaseAnalytics.logEvent(name: analyticEvent.toSnakeCase(), parameters: sneakCaseParameters);
  }

  void logSignUpEventToFirebase(AnalyticsEvent signUpMethod) {
    logEventToFirebase(signUpMethod, parameters: {AnalyticsParameter.signUpMethod: signUpMethod.toSnakeCase()});
  }
}
