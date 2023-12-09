import 'package:cashback/core/constants/image_constants.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/expedition_controller.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:cashback/features/home/widgets/expedition_card.dart';
import 'package:cashback/features/home/widgets/filter_chip.dart';
import 'package:cashback/features/home/widgets/expedition_screen_filters_row.dart';
import 'package:cashback/features/home/widgets/expedition_screen_header.dart';
import 'package:cashback/features/home/widgets/filter_info_section.dart';
import 'package:flutter/material.dart' hide FilterChip;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ExpeditionScreen extends ConsumerWidget {
  static const routeName = '/expedition';
  const ExpeditionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.invalidate(todayTomorrowProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExpeditionScreenHeader(),
            const ExpeditionScreenFiltersRow(),
            Consumer(
              builder: (context, ref, child) {
                final filteredList = ref.watch(filterChipProvider);
                return filteredList.length < 2
                    ? switch (filteredList.firstOrNull) {
                        FilterType.sunrise => const FilterInfoSection(
                            text: "Sadece Sabaha Karşı (00:00 - 05:00 arası) seferleri gösterilmektedir.",
                          ),
                        FilterType.morning => const FilterInfoSection(
                            text: "Sadece Sabah (05:00 - 12:00 arası) seferleri gösterilmektedir."),
                        FilterType.afternoon => const FilterInfoSection(
                            text: "Sadece Öğlen (12:00 - 17:00 arası) seferleri gösterilmektedir."),
                        FilterType.night => const FilterInfoSection(
                            text: "Sadece Akşam (17:00 - 22:00 arası) seferleri gösterilmektedir."),
                        _ => const SizedBox(),
                      }
                    : const FilterInfoSection(
                        text: "Sadece filtrelenmiş seferler gösterilmektedir.",
                      );
              },
            ),
            ref.watch(expeditionControllerProvider).when(
              data: (expeditions) {
                // sort by date
                return Expanded(
                  child: expeditions.isNotEmpty
                      ? ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: expeditions.length,
                          padding: context.paddingLow * 2,
                          itemBuilder: (BuildContext context, int index) {
                            final expedition = expeditions[index];
                            return ExpeditionCard(
                              expedition: expedition,
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              ImageConstants.noExpedition,
                              fit: BoxFit.fitWidth,
                              height: context.height * 0.4,
                            ),
                            const Gap(20),
                            Text(
                              "Sefer bulunamadı",
                              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: context.primaryColor),
                            ),
                          ],
                        ),
                );
              },
              error: (error, stackTrace) {
                return const Center(child: Text("Error"));
              },
              loading: () {
                return const Expanded(child: Center(child: CircularProgressIndicator.adaptive()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
