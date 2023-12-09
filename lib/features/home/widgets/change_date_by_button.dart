import 'package:cashback/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChangeDateByButton extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String text;
  final VoidCallback? onTap;
  const ChangeDateByButton({
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 18, bottom: 10),
        padding: context.paddingLow / 1.5,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            leadingIcon != null
                ? Icon(
                    leadingIcon,
                    color: Colors.white,
                    size: 13,
                  )
                : const SizedBox.shrink(),
            const Gap(15),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            trailingIcon != null
                ? Icon(
                    trailingIcon,
                    color: Colors.white,
                    size: 13,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
