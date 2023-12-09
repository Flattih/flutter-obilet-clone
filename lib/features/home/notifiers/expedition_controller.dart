import 'dart:async';

import 'package:cashback/core/extension/string_extension.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:cashback/features/home/repository/expedition_repository.dart';
import 'package:cashback/features/home/widgets/filter_chip.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expeditionControllerProvider = AsyncNotifierProvider.autoDispose<ExpeditionController, List<Expedition>>(
  ExpeditionController.new,
);
final expeditionListCopyProvider = StateProvider<List<Expedition>>((ref) => []);

enum FilterType { price, time, sunrise, morning, afternoon, night }

final filterTypeProvider = StateProvider.autoDispose<List<FilterType>>((ref) => []);

class ExpeditionController extends AutoDisposeAsyncNotifier<List<Expedition>> {
  @override
  FutureOr<List<Expedition>> build() {
    final homeController = ref.read(homeControllerProvider);
    return getExpeditionsByDate(homeController.date, homeController.from, homeController.to);
  }

  Future<List<Expedition>> getExpeditionsByDate(String date, String from, String to) async {
    try {
      state = const AsyncValue.loading();
      final expeditions = await ref.read(expeditionRepositoryProvider).getExpeditionsByDate(date, from, to);
      state = AsyncValue.data(expeditions);
      ref.read(expeditionListCopyProvider.notifier).update((state) => expeditions);
      sortByDate();
      return expeditions;
    } catch (e) {
      return [];
    }
  }

  Future<bool> reserveSeat(String expeditionId) async {
    try {
      return await ref.read(expeditionRepositoryProvider).reserveSeat(expeditionId, ref);
    } catch (e) {
      return false;
    }
  }

  Future<void> updateExpeditionById(String expeditionId) async {
    try {
      final expedition = await ref.read(expeditionRepositoryProvider).getExpeditionById(expeditionId);
      state = AsyncValue.data(state.requireValue.map((e) => e.id == expedition.id ? expedition : e).toList());
    } catch (e) {
      Future.error(e);
    }
  }

  void sortByDate() {
    state = AsyncValue.data(state.requireValue..sort((a, b) => a.departureTime!.compareTo(b.departureTime!)));
  }

  void sortByPrice() {
    state = AsyncValue.data(state.requireValue..sort((a, b) => int.parse(a.price!).compareTo(int.parse(b.price!))));
  }

  void filterByDate() {
    final initialList = ref.read(expeditionListCopyProvider);
    final filters = ref.read(filterChipProvider);
    final isMorningFilter = filters.contains(FilterType.morning);
    final isAfternoonFilter = filters.contains(FilterType.afternoon);
    final isNightFilter = filters.contains(FilterType.night);
    final isSunriseFilter = filters.contains(FilterType.sunrise);
    //Filter
    if (isMorningFilter && isAfternoonFilter && isNightFilter && isSunriseFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 0 && element.departureTime!.hour < 24)
          .toList());
    } else if (isMorningFilter && isAfternoonFilter && isNightFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 5 && element.departureTime!.hour < 22)
          .toList());
    } else if (isMorningFilter && isAfternoonFilter && isSunriseFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 0 && element.departureTime!.hour < 17)
          .toList());
    } else if (isMorningFilter && isNightFilter && isSunriseFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 0 && element.departureTime!.hour < 22)
          .toList());
    } else if (isAfternoonFilter && isNightFilter && isSunriseFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 0 && element.departureTime!.hour < 24)
          .toList());
    } else if (isMorningFilter && isAfternoonFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 5 && element.departureTime!.hour < 17)
          .toList());
    } else if (isMorningFilter && isNightFilter) {
      state = AsyncValue.data(initialList
          .where((element) =>
              (element.departureTime!.hour >= 5 && element.departureTime!.hour < 12) ||
              (element.departureTime!.hour >= 17 && element.departureTime!.hour < 22))
          .toList());
    } else if (isMorningFilter && isSunriseFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 0 && element.departureTime!.hour < 12)
          .toList());
    } else if (isAfternoonFilter && isNightFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 12 && element.departureTime!.hour < 22)
          .toList());
    } else if (isSunriseFilter) {
      state = AsyncValue.data(
          initialList.where((element) => element.departureTime!.hour >= 0 && element.departureTime!.hour < 5).toList());
    } else if (isMorningFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 5 && element.departureTime!.hour < 12)
          .toList());
    } else if (isAfternoonFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 12 && element.departureTime!.hour < 17)
          .toList());
    } else if (isNightFilter) {
      state = AsyncValue.data(initialList
          .where((element) => element.departureTime!.hour >= 17 && element.departureTime!.hour < 22)
          .toList());
    } else {
      state = AsyncValue.data(initialList);
    }
  }
}

final canGoToPreviousDayProvider = Provider.autoDispose<bool>((ref) {
  final today = ref.watch(homeControllerProvider).date;
  final now = DateTime.now();
  final todayDate = DateTime(now.year, now.month, now.day);
  final selectedDate = DateTime.parse(today.toYearMonthDay());
  return selectedDate.isAfter(todayDate);
});
