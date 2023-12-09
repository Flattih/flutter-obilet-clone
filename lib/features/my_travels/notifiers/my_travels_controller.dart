import 'dart:async';

import 'package:cashback/features/home/repository/expedition_repository.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myTravelsController = AsyncNotifierProvider.autoDispose<MyTravelsController, List<Expedition>>(
  MyTravelsController.new,
);

class MyTravelsController extends AutoDisposeAsyncNotifier<List<Expedition>> {
  @override
  FutureOr<List<Expedition>> build() async {
    try {
      final expeditions = await ref.read(expeditionRepositoryProvider).getExpeditionsByUserId();
      state = AsyncValue.data(expeditions);
      return expeditions;
    } catch (e, st) {
      AsyncValue.error(e, st);
      return [];
    }
  }
}
