import 'package:cashback/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Bu kod hakkında daha fazla bilgi için: https://codewithandrea.com/articles/robust-app-initialization-riverpod/

class AppStartupWidget extends ConsumerStatefulWidget {
  const AppStartupWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<AppStartupWidget> {
  @override
  Widget build(BuildContext context) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (_) => const MyApp(),
      loading: () => const AppStartupLoadingWidget(),
      error: (error, stack) => AppStartupErrorWidget(
        message: error.toString(),
        onRetry: () {
          ref.invalidate(appStartupProvider);
        },
      ),
    );
  }
}

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async => SharedPreferences.getInstance());

final appStartupProvider = FutureProvider<void>((ref) async {
  ref.onDispose(() {
    // Ensure we invalidate all the providers we depend on
    ref.invalidate(sharedPreferencesProvider);
  });
  // All async app initialization code goes here

  await Future.wait([
    ref.watch(sharedPreferencesProvider.future),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    EasyLocalization.ensureInitialized()
  ]);
});

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, style: Theme.of(context).textTheme.headlineSmall),
              const Gap(16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
