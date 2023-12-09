import 'package:cashback/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class BusSeatType extends StatelessWidget {
  final String text;
  final Color color;
  final BoxBorder? border;
  const BusSeatType({
    super.key,
    required this.text,
    required this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: context.paddingLow,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: border,
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Text(text)
      ],
    );
  }
}
