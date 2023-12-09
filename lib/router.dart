import 'package:cashback/features/auth/screens/sign_in_screen.dart';
import 'package:cashback/features/auth/screens/sign_up_screen.dart';
import 'package:cashback/features/bottom_bar/bottom_bar.dart';
import 'package:cashback/features/home/screens/expedition_screen.dart';
import 'package:cashback/features/home/screens/home_screen.dart';
import 'package:cashback/features/home/screens/payment_screen.dart';
import 'package:cashback/features/home/screens/search_screen.dart';
import 'package:cashback/features/welcome/welcome_screen.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  return switch (routeSettings.name) {
    BottomNavBar.routeName => FadePageRoute(builder: (context) => const BottomNavBar()),
    WelcomeScreen.routeName => FadePageRoute(builder: (context) => const WelcomeScreen()),
    SignUpScreen.routeName => FadePageRoute(builder: (context) => const SignUpScreen()),
    SignInScreen.routeName => FadePageRoute(builder: (context) => const SignInScreen()),
    HomeScreen.routeName => FadePageRoute(builder: (context) => const HomeScreen()),
    PaymentScreen.routeName => FadePageRoute(builder: (context) {
        final expedition = routeSettings.arguments as Expedition;
        return PaymentScreen(expedition: expedition);
      }),
    ExpeditionScreen.routeName => MaterialPageRoute(builder: (context) => const ExpeditionScreen()),
    SearchScreen.routeName => MaterialPageRoute(builder: (context) {
        final isFrom = routeSettings.arguments as bool;
        return SearchScreen(
          isFrom: isFrom,
        );
      }),
    _ => MaterialPageRoute(builder: (context) => const Scaffold()),
  };
}

class FadePageRoute<T> extends CupertinoPageRoute<T> {
  FadePageRoute({required super.builder});

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final widget = super.buildTransitions(context, animation, secondaryAnimation, child);
    if (widget is CupertinoPageTransition) {
      return FadeTransition(
        opacity: animation,
        child: widget.child,
      );
    } else {
      return widget;
    }
  }
}
