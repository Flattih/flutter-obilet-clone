import 'dart:io';

import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/selected_seats_controller.dart';
import 'package:cashback/features/home/widgets/gender_selection_widget.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class BusSeat extends ConsumerWidget {
  const BusSeat(
      {super.key,
      required this.expiditionId,
      required this.seatNumber,
      this.width,
      this.height,
      this.gender = Gender.EMPTY});

  final int seatNumber;
  final String expiditionId;
  final Gender? gender;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSeats = ref.watch(selectedSeatsControllerProvider);
    return StatefulBuilder(
      builder: (context, setState) => GestureDetector(
        onTap: () {
          if (gender != Gender.EMPTY) return;
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog.adaptive(
                backgroundColor: const Color(0xFF0FA67C),
                actions: Platform.isAndroid
                    ? null
                    : [
                        GenderSelectionWidget(
                          onTap: () {
                            ref.read(selectedSeatsControllerProvider.notifier).add(seatNumber, Gender.MAN);
                            context.pop();
                          },
                          icon: Icons.man,
                          text: "ERKEK",
                        ),
                        GenderSelectionWidget(
                          text: "KADIN",
                          icon: Icons.woman,
                          onTap: () {
                            ref.read(selectedSeatsControllerProvider.notifier).add(seatNumber, Gender.WOMAN);
                            context.pop();
                          },
                        )
                      ],
                content: Platform.isAndroid
                    ? SizedBox(
                        height: 80,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          GenderSelectionWidget(
                            onTap: () {
                              ref.read(selectedSeatsControllerProvider.notifier).add(seatNumber, Gender.MAN);
                              context.pop();
                            },
                            icon: Icons.man,
                            text: "ERKEK",
                          ),
                          const Gap(20),
                          GenderSelectionWidget(
                            text: "KADIN",
                            icon: Icons.woman,
                            onTap: () {
                              ref.read(selectedSeatsControllerProvider.notifier).add(seatNumber, Gender.WOMAN);
                              context.pop();
                            },
                          )
                        ]),
                      )
                    : null,
              );
            },
          );
        },
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: selectedSeats.where((element) => element.seatNumber == seatNumber).isNotEmpty
                    ? null
                    : gender == Gender.EMPTY
                        ? Border.all()
                        : null,
                borderRadius: BorderRadius.circular(5),
                color: selectedSeats.where((element) => element.seatNumber == seatNumber).isNotEmpty
                    ? const Color(0xFF0FA67C)
                    : switch (gender) {
                        Gender.EMPTY => Colors.white,
                        Gender.MAN => const Color(0xFF6797C2),
                        Gender.WOMAN => const Color(0xFFEEB1C0),
                        _ => Colors.white,
                      },
              ),
              child: Text(seatNumber.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      color: selectedSeats.where((element) => element.seatNumber == seatNumber).isNotEmpty
                          ? Colors.white
                          : Colors.black)),
            ),
            selectedSeats.where((element) => element.seatNumber == seatNumber).isNotEmpty
                ? Positioned(
                    top: 6,
                    right: 3,
                    child: GestureDetector(
                      onTap: () {
                        ref.read(selectedSeatsControllerProvider.notifier).remove(seatNumber);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: selectedSeats
                                  .where((element) => element.seatNumber == seatNumber && element.gender == Gender.MAN)
                                  .isNotEmpty
                              ? const Color(0xFF6797C2)
                              : const Color(0xFFEEB1C0),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
