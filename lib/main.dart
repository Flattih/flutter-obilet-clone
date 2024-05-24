import 'package:cashback/core/lang/language_manager.dart';
import 'package:cashback/core/theme/app_theme.dart';
import 'package:cashback/features/auth/notifiers/auth_controller.dart';
import 'package:cashback/router.dart';
import 'package:cashback/features/auth/widgets/auth_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ProviderScope(
      child: LanguageManager(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    ref.read(authControllerProvider.notifier).getUser();
    FlutterNativeSplash.remove();
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: EasyLoading.init(),
      onGenerateRoute: (settings) => generateRoute(settings),
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider),
      title: 'Obilet',
      home: const AuthWidget(),
    );
  }
}
