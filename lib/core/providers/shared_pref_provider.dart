import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class SharedKeys {
  SharedKeys._();

  static const String rememberMe = "rememberMe";
  static const String theme = 'theme';
}
