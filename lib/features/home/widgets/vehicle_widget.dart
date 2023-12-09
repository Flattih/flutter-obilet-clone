import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class VehicleWidget extends ConsumerWidget {
  final IconData icon;
  final String text;
  final VehicleType vehicleType;
  final VoidCallback onTap;
  final double? iconSize;
  const VehicleWidget({
    required this.icon,
    required this.text,
    required this.vehicleType,
    required this.onTap,
    this.iconSize,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVehicleType = ref.watch(vehicleTypeProvider);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: context.paddingLow * 1.5,
        decoration: BoxDecoration(
          color: selectedVehicleType == vehicleType ? context.secondaryColor : Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            FaIcon(
              icon,
              color: selectedVehicleType == vehicleType ? Colors.white : Colors.grey,
              size: iconSize ?? 14,
            ),
            const Gap(10),
            Text(
              text,
              style: TextStyle(
                  color: selectedVehicleType == vehicleType ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
