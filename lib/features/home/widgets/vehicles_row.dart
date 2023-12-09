import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:cashback/features/home/widgets/vehicle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VehiclesRow extends ConsumerWidget {
  const VehiclesRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: -20,
      child: Container(
        padding: context.paddingLow / 5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VehicleWidget(
              vehicleType: VehicleType.bus,
              icon: FontAwesomeIcons.busSimple,
              text: "Otobüs",
              onTap: () {
                ref.read(vehicleTypeProvider.notifier).update((state) => VehicleType.bus);
              },
            ),
            VehicleWidget(
              vehicleType: VehicleType.plane,
              icon: FontAwesomeIcons.plane,
              text: "Uçak",
              onTap: () {
                ref.read(vehicleTypeProvider.notifier).update((state) => VehicleType.plane);
              },
            ),
            VehicleWidget(
              vehicleType: VehicleType.hotel,
              icon: Icons.hotel,
              iconSize: 18,
              text: "Otel",
              onTap: () {
                ref.read(vehicleTypeProvider.notifier).update((state) => VehicleType.hotel);
              },
            ),
            VehicleWidget(
              vehicleType: VehicleType.ship,
              icon: FontAwesomeIcons.ship,
              text: "Feribot",
              onTap: () {
                ref.read(vehicleTypeProvider.notifier).update((state) => VehicleType.ship);
              },
            ),
          ],
        ),
      ),
    );
  }
}
