import 'package:cashback/features/home/notifiers/expedition_controller.dart';
import 'package:cashback/features/home/widgets/filter_chip.dart';
import 'package:flutter/material.dart' hide FilterChip;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpeditionScreenFiltersRow extends ConsumerWidget {
  const ExpeditionScreenFiltersRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: AnimatedFilterChip(
              text: 'SIRALA',
              onTap: () {},
            ),
          ),
          FilterChip(
            filterType: FilterType.time,
            text: 'FİLTRE',
            isHardCoded: true,
            hardCodedIcon: Icons.filter_list,
            onTap: () {},
          ),
          FilterChip(
              filterType: FilterType.sunrise,
              text: "Sabaha Karşı",
              onTap: () {
                ref.read(filterChipProvider.notifier).addFilterOrRemove(FilterType.sunrise);
              }),
          FilterChip(
            filterType: FilterType.morning,
            text: "Sabah",
            onTap: () {
              ref.read(filterChipProvider.notifier).addFilterOrRemove(FilterType.morning);
            },
          ),
          FilterChip(
            filterType: FilterType.afternoon,
            text: "Öğle",
            onTap: () {
              ref.read(filterChipProvider.notifier).addFilterOrRemove(FilterType.afternoon);
            },
          ),
          FilterChip(
            filterType: FilterType.night,
            text: "Akşam",
            onTap: () {
              ref.read(filterChipProvider.notifier).addFilterOrRemove(FilterType.night);
            },
          )
        ],
      ),
    );
  }
}
