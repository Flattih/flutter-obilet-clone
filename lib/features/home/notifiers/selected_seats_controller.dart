import 'package:cashback/features/home/models/seat_model.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSeatsControllerProvider =
    NotifierProvider.autoDispose<SelectedSeatsController, List<SeatModel>>(SelectedSeatsController.new);

class SelectedSeatsController extends AutoDisposeNotifier<List<SeatModel>> {
  @override
  List<SeatModel> build() {
    return [];
  }

  void add(int seatNumber, Gender gender) {
    if (state.where((element) => element.seatNumber == seatNumber).isEmpty) {
      state = [...state, SeatModel(seatNumber: seatNumber, gender: gender)];
    }
  }

  void remove(int seatNumber) {
    state = state.where((element) => element.seatNumber != seatNumber).toList();
  }
}
