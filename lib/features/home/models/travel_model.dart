class TravelModel {
  final String from;
  final String to;
  final String date;
  TravelModel({
    required this.from,
    required this.to,
    required this.date,
  });

  factory TravelModel.initial() {
    final today = DateTime.now();
    final formattedDate = "${today.month}-${today.day}-${today.year}";
    return TravelModel(
      from: 'İstanbul',
      to: 'Ankara',
      date: formattedDate,
    );
  }

  TravelModel copyWith({
    String? from,
    String? to,
    String? date,
  }) {
    return TravelModel(
      from: from ?? this.from,
      to: to ?? this.to,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'date': date,
    };
  }

  factory TravelModel.fromMap(Map<String, dynamic> map) {
    return TravelModel(
      from: map['from'] as String,
      to: map['to'] as String,
      date: map['date'] as String,
    );
  }

  @override
  String toString() => 'TravelModel(from: $from, to: $to, date: $date)';

  @override
  bool operator ==(covariant TravelModel other) {
    if (identical(this, other)) return true;

    return other.from == from && other.to == to && other.date == date;
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode ^ date.hashCode;
}
