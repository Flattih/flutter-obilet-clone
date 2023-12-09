import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/selected_seats_controller.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedSeat extends ConsumerWidget {
  final String seatNumber;
  const SelectedSeat({super.key, required this.seatNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 30,
      margin: context.paddingLowHorizontal,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ref
                .watch(selectedSeatsControllerProvider)
                .where((element) => element.seatNumber == int.parse(seatNumber) && element.gender == Gender.MAN)
                .isNotEmpty
            ? const Color(0xFF6797C2)
            : const Color(0xFFEEB1C0),
      ),
      child: Text(seatNumber, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
