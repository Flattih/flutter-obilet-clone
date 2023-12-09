import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/expedition_controller.dart';
import 'package:cashback/features/home/widgets/filter_chip.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterInfoSection extends StatelessWidget {
  final String text;
  const FilterInfoSection({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: (context.paddingMediumVertical / 2.8).copyWith(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: context.paddingLowHorizontal * 2,
      alignment: Alignment.center,
      child: Consumer(
        builder: (context, ref, child) {
          return Text.rich(
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54),
            TextSpan(
              text: "$text \n",
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ref.read(filterChipProvider.notifier).clear();
                      ref.read(expeditionControllerProvider.notifier).filterByDate();
                    },
                  text: "Tüm seferler için dokunun.",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
