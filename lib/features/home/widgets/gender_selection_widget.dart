import 'package:cashback/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GenderSelectionWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final IconData icon;
  const GenderSelectionWidget({
    required this.text,
    required this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          const Gap(10),
          Icon(icon, size: 34),
          Padding(
            padding: context.paddingLowVertical,
            child: Text(text),
          )
        ],
      ),
    );
  }
}
