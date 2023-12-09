import 'package:cashback/core/common/error_page.dart';
import 'package:cashback/core/common/loading_page.dart';
import 'package:cashback/features/auth/notifiers/auth_controller.dart';
import 'package:cashback/features/bottom_bar/bottom_bar.dart';
import 'package:cashback/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChanges).when(
          data: (user) => user != null ? const BottomNavBar() : const WelcomeScreen(),
          error: (e, st) => ErrorPage(error: e.toString()),
          loading: () => const LoadingPage(),
        );
  }
}
