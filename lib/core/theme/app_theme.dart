import 'package:cashback/core/providers/shared_pref_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final themeProvider = StateNotifierProvider<AppTheme, ThemeData>((ref) {
  return AppTheme(ref: ref);
});

class AppTheme extends StateNotifier<ThemeData> {
  final Ref ref;
  AppTheme({required this.ref}) : super(lightTheme) {
    getTheme();
  }

  static ThemeData lightTheme = ThemeData.light(useMaterial3: false).copyWith(
    textTheme: GoogleFonts.carmeTextTheme().copyWith(
      titleMedium: const TextStyle(fontWeight: FontWeight.bold),
    ),
    primaryColor: const Color(0xFFD13C39),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFD13C39),
      secondary: Colors.red,
    ),
    listTileTheme: const ListTileThemeData(tileColor: Colors.white),
    chipTheme: ChipThemeData(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      labelStyle: const TextStyle(color: Colors.white),
    ),
    checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: const BorderSide(color: Colors.grey)),
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.grey,
      hintStyle: TextStyle(color: Colors.grey),
    ),
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(foregroundColor: Colors.white, backgroundColor: Color(0xFF0FA67C)),
    outlinedButtonTheme:
        OutlinedButtonThemeData(style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFF0FA67C))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 18),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData.dark(useMaterial3: false).copyWith(
    primaryColor: Colors.teal,
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.white,
      filled: true,
      fillColor: Colors.black54,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textTheme: GoogleFonts.notoSerifTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );

  void getTheme() {
    final theme = ref.watch(sharedPreferencesProvider).getString(SharedKeys.theme);

    if (theme == ThemeMode.dark.name) {
      state = darkTheme;
    } else {
      state = lightTheme;
    }
  }

  void toggleTheme() async {
    if (state == darkTheme) {
      await ref.watch(sharedPreferencesProvider).setString(SharedKeys.theme, ThemeMode.light.name);
      state = lightTheme;
    } else {
      await ref.watch(sharedPreferencesProvider).setString(SharedKeys.theme, ThemeMode.dark.name);
      state = darkTheme;
    }
  }
}
