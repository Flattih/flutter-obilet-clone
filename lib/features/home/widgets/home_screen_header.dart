import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/widgets/vehicles_row.dart';
import 'package:flutter/material.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        ColoredBox(
          color: context.primaryColor,
          child: const SizedBox(
            height: 250,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "obilet",
                  style: context.textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ".com",
                  style: context.textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const VehiclesRow(),
      ],
    );
  }
}
