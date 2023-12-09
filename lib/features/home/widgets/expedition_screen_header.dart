import 'package:cashback/core/constants/image_constants.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/core/extension/date_time_extension.dart';
import 'package:cashback/core/extension/string_extension.dart';
import 'package:cashback/features/home/notifiers/expedition_controller.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:cashback/features/home/widgets/change_date_by_button.dart';
import 'package:cashback/features/home/widgets/filter_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ExpeditionScreenHeader extends ConsumerStatefulWidget {
  const ExpeditionScreenHeader({
    super.key,
  });

  @override
  ConsumerState<ExpeditionScreenHeader> createState() => _FindScreenHeaderState();
}

class _FindScreenHeaderState extends ConsumerState<ExpeditionScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.primaryColor,
      child: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: BackButton(
                      color: Colors.white,
                    ),
                  ),
                  const Gap(60),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      ref.watch(homeControllerProvider).from,
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: swapCities,
                    child: Container(
                      padding: context.paddingLow / 6,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Image.asset(
                        ImageConstants.leftAndRightArrows,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      ref.watch(homeControllerProvider).to,
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            },
          ),
          const Gap(10),
          Consumer(
            builder: (context, ref, child) {
              final canGoToPreviousDay = ref.watch(canGoToPreviousDayProvider);
              return FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Row(
                    children: [
                      canGoToPreviousDay
                          ? ChangeDateByButton(
                              leadingIcon: Icons.arrow_back_ios,
                              text: "Önceki",
                              onTap: _beforeDay,
                            )
                          : const SizedBox.shrink(),
                      ChangeDateByButton(
                        leadingIcon: Icons.date_range,
                        text: _formattedDate(),
                        onTap: _pickDate,
                      ),
                      ChangeDateByButton(
                        text: "Sonraki",
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: _afterDay,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  String _formattedDate() {
    final state = ref.watch(homeControllerProvider);
    final dayName = state.date.toDateTime().getDayName();
    final formattedDate = state.date.toDateTime().format('MMMMd', 'tr_TR');
    final unifiedDate = "$formattedDate $dayName";
    return unifiedDate;
  }

  void _beforeDay() {
    ref.read(homeControllerProvider.notifier).updateToBeforeDay();
    ref.invalidate(filterChipProvider);
    final state = ref.watch(homeControllerProvider);
    ref.read(expeditionControllerProvider.notifier).getExpeditionsByDate(state.date, state.from, state.to);
  }

  void _afterDay() {
    ref.read(homeControllerProvider.notifier).updateToNextDay();
    ref.invalidate(filterChipProvider);
    ref.read(expeditionControllerProvider.notifier).getExpeditionsByDate(ref.read(homeControllerProvider).date,
        ref.read(homeControllerProvider).from, ref.read(homeControllerProvider).to);
  }

  void swapCities() {
    ref.read(homeControllerProvider.notifier).swap();
    ref.invalidate(filterChipProvider);
    ref.read(expeditionControllerProvider.notifier).getExpeditionsByDate(ref.read(homeControllerProvider).date,
        ref.read(homeControllerProvider).from, ref.read(homeControllerProvider).to);
  }

  void _pickDate() async {
    final previousState = ref.read(homeControllerProvider);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: previousState.date.toDateTime(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      String formattedDate = "${pickedDate.month}-${pickedDate.day}-${pickedDate.year}";
      ref.read(homeControllerProvider.notifier).updateDate(formattedDate);
    }
    final state = ref.read(homeControllerProvider);
    ref.read(expeditionControllerProvider.notifier).getExpeditionsByDate(state.date, state.from, state.to);
  }
}
