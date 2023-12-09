import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/core/extension/string_extension.dart';
import 'package:cashback/features/home/mixin/home_screen_mixin.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:cashback/features/home/screens/expedition_screen.dart';
import 'package:cashback/features/home/widgets/from_to_widget.dart';
import 'package:cashback/features/home/widgets/home_screen_header.dart';
import 'package:cashback/features/home/widgets/today_or_tomorrow_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with HomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeScreenHeader(),
            const Gap(40),
            Consumer(
              builder: (context, ref, child) => switch (ref.watch(vehicleTypeProvider)) {
                VehicleType.bus => Column(
                    children: [
                      const FromToWidget(),
                      const Gap(10),
                      Container(
                        padding: context.paddingLow.copyWith(top: 15),
                        margin: const EdgeInsets.all(18).copyWith(top: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: pickDate,
                              child: Padding(
                                padding: context.paddingNormal.copyWith(left: 5, right: 14, top: 14),
                                child: const Icon(Icons.date_range, color: Colors.grey),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("GİDİŞ TARİHİ",
                                      style: TextStyle(color: context.secondaryColor, fontWeight: FontWeight.bold)),
                                  const Gap(3),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final travelDate =
                                          ref.watch(homeControllerProvider.select((travelModel) => travelModel.date));
                                      return Text(
                                        travelDate.toFormattedDate(),
                                        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                      );
                                    },
                                  ),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.3),
                                    thickness: 1,
                                  ),
                                  const Gap(3),
                                  Row(
                                    children: [
                                      TodayOrTomorrowChip(
                                        todayOrTomorrow: TodayTomorrow.today,
                                        text: "Bugün",
                                        onTap: pickToday,
                                      ),
                                      const Gap(15),
                                      TodayOrTomorrowChip(
                                        todayOrTomorrow: TodayTomorrow.tomorrow,
                                        text: "Yarın",
                                        onTap: pickTomorrow,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: context.width - 110,
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () {
                            context.toNamed(ExpeditionScreen.routeName);
                          },
                          child: const Text(
                            "Otobüs Bileti Bul",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text("Kesintisiz İade Hakkı ve 0 Komisyon",
                          style: TextStyle(color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.bold)),
                    ],
                  ),
                VehicleType.hotel => const Center(
                    child: Text("Otel"),
                  ),
                VehicleType.ship => const Center(
                    child: Text("Feribot"),
                  ),
                VehicleType.plane => const Center(
                    child: Text("Uçak"),
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
