import 'package:cashback/features/home/screens/home_screen.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin HomeScreenMixin on ConsumerState<HomeScreen> {
  void pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      String formattedDate = "${date.month}-${date.day}-${date.year}";
      ref.read(homeControllerProvider.notifier).updateDate(formattedDate);
    }
  }

  void pickToday() {
    ref.read(todayTomorrowProvider.notifier).update((state) => TodayTomorrow.today);
    final today = DateTime.now();
    final formattedDate = "${today.month}-${today.day}-${today.year}";
    ref.read(homeControllerProvider.notifier).updateDate(formattedDate);
  }

  void pickTomorrow() {
    ref.read(todayTomorrowProvider.notifier).update((state) => TodayTomorrow.tomorrow);
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final formattedDate = "${tomorrow.month}-${tomorrow.day}-${tomorrow.year}";
    ref.read(homeControllerProvider.notifier).updateDate(formattedDate);
  }
}
