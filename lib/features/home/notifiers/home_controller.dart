import 'package:cashback/core/extension/date_time_extension.dart';
import 'package:cashback/core/extension/string_extension.dart';
import 'package:cashback/features/home/models/travel_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = NotifierProvider<HomeController, TravelModel>(HomeController.new);

enum VehicleType { bus, ship, plane, hotel }

enum TodayTomorrow { today, tomorrow }

final vehicleTypeProvider = StateProvider<VehicleType>((ref) => VehicleType.bus);
final todayTomorrowProvider = StateProvider.autoDispose<TodayTomorrow?>((ref) => null);

class HomeController extends Notifier<TravelModel> {
  @override
  TravelModel build() {
    return TravelModel.initial();
  }

  void swap() {
    state = state.copyWith(from: state.to, to: state.from);
  }

  void updateDate(String date) {
    state = state.copyWith(date: date);
  }

  void updateFrom(String city) {
    state = state.copyWith(from: city);
  }

  void updateTo(String city) {
    state = state.copyWith(to: city);
  }

  void updateToBeforeDay() {
    final date = state.date.toDateTime();
    final beforeDay = date.subtract(const Duration(days: 1));
    final formattedDate = "${beforeDay.month}-${beforeDay.day}-${beforeDay.year}";
    state = state.copyWith(date: formattedDate);
  }

  void updateToNextDay() {
    final date = state.date.toDateTime();
    final nextDay = date.add(const Duration(days: 1));
    final formattedDate = "${nextDay.month}-${nextDay.day}-${nextDay.year}";
    state = state.copyWith(date: formattedDate);
  }

  String formattedDate() {
    final dayName = state.date.toDateTime().getDayName();
    final formattedDate = state.date.toDateTime().format('MMMMd', 'tr_TR');
    state = state.copyWith(date: "$dayName, $formattedDate");
    return state.date;
  }
}
