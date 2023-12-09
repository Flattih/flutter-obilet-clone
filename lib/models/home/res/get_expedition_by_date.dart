// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Expedition {
  final String? id;
  final String? estimatedArrival;
  final DateTime? departureTime;
  final String? departurePlace;
  final String? destinationPlace;
  final String? price;
  final Agency? agency;
  final List<BusSeatNumber>? busSeatNumbers;

  Expedition({
    this.id,
    this.estimatedArrival,
    this.departureTime,
    this.departurePlace,
    this.destinationPlace,
    this.price,
    this.agency,
    this.busSeatNumbers,
  });

  Expedition copyWith({
    String? id,
    String? estimatedArrival,
    DateTime? departureTime,
    String? departurePlace,
    String? destinationPlace,
    String? price,
    Agency? agency,
    List<BusSeatNumber>? busSeatNumbers,
  }) =>
      Expedition(
        id: id ?? this.id,
        estimatedArrival: estimatedArrival ?? this.estimatedArrival,
        departureTime: departureTime ?? this.departureTime,
        departurePlace: departurePlace ?? this.departurePlace,
        destinationPlace: destinationPlace ?? this.destinationPlace,
        price: price ?? this.price,
        agency: agency ?? this.agency,
        busSeatNumbers: busSeatNumbers ?? this.busSeatNumbers,
      );

  factory Expedition.fromRawJson(String str) => Expedition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Expedition.fromJson(Map<String, dynamic> json) => Expedition(
        id: json["_id"],
        estimatedArrival: json["estimatedArrival"],
        departureTime: json["departureTime"] == null ? null : DateTime.parse(json["departureTime"]),
        departurePlace: json["departurePlace"],
        destinationPlace: json["destinationPlace"],
        price: json["price"],
        agency: json["agency"] == null ? null : Agency.fromJson(json["agency"]),
        busSeatNumbers: json["busSeatNumbers"] == null
            ? []
            : List<BusSeatNumber>.from(json["busSeatNumbers"]!.map((x) => BusSeatNumber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "estimatedArrival": estimatedArrival,
        "departureTime": departureTime?.toIso8601String(),
        "departurePlace": departurePlace,
        "destinationPlace": destinationPlace,
        "price": price,
        "agency": agency?.toJson(),
        "busSeatNumbers": busSeatNumbers == null ? [] : List<dynamic>.from(busSeatNumbers!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Expedition(id: $id, estimatedArrival: $estimatedArrival, departureTime: $departureTime, departurePlace: $departurePlace, destinationPlace: $destinationPlace, price: $price, agency: $agency, busSeatNumbers: $busSeatNumbers)';
  }
}

class Agency {
  final String? id;
  final String? name;
  final String? logo;
  final List<dynamic>? expeditions;

  Agency({
    this.id,
    this.name,
    this.logo,
    this.expeditions,
  });

  Agency copyWith({
    String? id,
    String? name,
    String? logo,
    List<dynamic>? expeditions,
  }) =>
      Agency(
        id: id ?? this.id,
        name: name ?? this.name,
        logo: logo ?? this.logo,
        expeditions: expeditions ?? this.expeditions,
      );

  factory Agency.fromRawJson(String str) => Agency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Agency.fromJson(Map<String, dynamic> json) => Agency(
        id: json["_id"],
        name: json["name"],
        logo: json["logo"],
        expeditions: json["expeditions"] == null ? [] : List<dynamic>.from(json["expeditions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "logo": logo,
        "expeditions": expeditions == null ? [] : List<dynamic>.from(expeditions!.map((x) => x)),
      };
}

class BusSeatNumber {
  final String? id;
  final int? number;
  final Gender? gender;
  final bool? isAvailable;
  final String? userId;

  BusSeatNumber({
    this.id,
    this.number,
    this.gender,
    this.isAvailable,
    this.userId,
  });

  BusSeatNumber copyWith({
    String? id,
    int? number,
    Gender? gender,
    bool? isAvailable,
    String? userId,
  }) =>
      BusSeatNumber(
        id: id ?? this.id,
        number: number ?? this.number,
        gender: gender ?? this.gender,
        isAvailable: isAvailable ?? this.isAvailable,
        userId: userId ?? this.userId,
      );

  factory BusSeatNumber.fromRawJson(String str) => BusSeatNumber.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BusSeatNumber.fromJson(Map<String, dynamic> json) => BusSeatNumber(
        id: json["_id"],
        number: json["number"],
        gender: genderValues.map[json["gender"]]!,
        isAvailable: json["isAvailable"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "number": number,
        "gender": genderValues.reverse[gender],
        "isAvailable": isAvailable,
        "userId": userId,
      };

  @override
  String toString() {
    return 'BusSeatNumber(id: $id, number: $number, gender: $gender, isAvailable: $isAvailable, userId: $userId)';
  }
}

enum Gender { EMPTY, MAN, WOMAN }

final genderValues = EnumValues({"empty": Gender.EMPTY, "man": Gender.MAN, "woman": Gender.WOMAN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
