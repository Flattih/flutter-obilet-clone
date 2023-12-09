import 'package:cashback/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent])),
              height: 1,
              width: double.infinity),
        ),
        Padding(
          padding: context.paddingNormal,
          child: const Text("veya"),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black])),
            height: 1,
          ),
        ),
      ],
    );
  }
}
