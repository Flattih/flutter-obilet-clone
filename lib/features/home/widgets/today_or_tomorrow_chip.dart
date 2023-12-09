import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodayOrTomorrowChip extends ConsumerWidget {
  final TodayTomorrow todayOrTomorrow;
  final String text;
  final VoidCallback onTap;
  const TodayOrTomorrowChip({
    required this.todayOrTomorrow,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayTomorrowState = ref.watch(todayTomorrowProvider);
    return InkWell(
      onTap: onTap,
      child: Chip(
        side: BorderSide(color: todayTomorrowState == todayOrTomorrow ? Colors.transparent : Colors.black),
        label: Text(
          text,
          style: TextStyle(color: todayTomorrowState == todayOrTomorrow ? Colors.white : Colors.black54),
        ),
        backgroundColor: todayTomorrowState == todayOrTomorrow ? context.primaryColor : Colors.white,
      ),
    );
  }
}
