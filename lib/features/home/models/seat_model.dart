import 'package:cashback/models/home/res/get_expedition_by_date.dart';

class SeatModel {
  final int seatNumber;
  final Gender gender;

  SeatModel({required this.seatNumber, required this.gender});

  SeatModel copyWith({
    int? seatNumber,
    Gender? gender,
  }) {
    return SeatModel(
      seatNumber: seatNumber ?? this.seatNumber,
      gender: gender ?? this.gender,
    );
  }

  @override
  String toString() => 'SeatModel(seatNumber: $seatNumber, gender: $gender)';
}
