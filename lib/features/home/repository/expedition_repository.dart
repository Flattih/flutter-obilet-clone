import 'dart:convert';

import 'package:cashback/core/constants/api_constants.dart';
import 'package:cashback/core/network/dio_client.dart';
import 'package:cashback/features/home/notifiers/selected_seats_controller.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expeditionRepositoryProvider =
    Provider<ExpeditionRepository>((ref) => ExpeditionRepository(dio: ref.read(dioClientProvider).dio));

class ExpeditionRepository {
  final Dio _dio;
  ExpeditionRepository({required Dio dio}) : _dio = dio;

  Future<List<Expedition>> getExpeditionsByDate(String date, String from, String to) async {
    try {
      final response = await _dio.get("${ApiConstants.GET_EXPEDITION_BY_DATE_URL}/$date/$from/$to");
      final data = response.data as List;
      final expeditions = data.map((e) => Expedition.fromJson(e)).toList();
      return expeditions;
    } catch (e) {
      return [];
    }
  }

  Future<Expedition> getExpeditionById(String expeditionId) async {
    try {
      final response = await _dio.get("${ApiConstants.GET_EXPEDITION_BY_ID_URL}/$expeditionId");
      return Expedition.fromJson(response.data);
    } catch (e) {
      return Expedition();
    }
  }

  Future<List<Expedition>> getExpeditionsByUserId() async {
    try {
      final response = await _dio.get(ApiConstants.GET_EXPEDITION_BY_USER_ID_URL);
      final data = response.data as List;
      final expeditions = data.map((e) => Expedition.fromJson(e)).toList();
      return expeditions;
    } catch (e) {
      return [];
    }
  }

  Future<bool> reserveSeat(String expeditionId, Ref ref) async {
    try {
      final response = await _dio.post(
        ApiConstants.RESERVE_SEAT_URL,
        data: jsonEncode(
          {
            "expeditionId": expeditionId,
            "selectedSeatMap": {
              for (var element in ref.read(selectedSeatsControllerProvider))
                element.seatNumber.toString(): element.gender.name.toLowerCase()
            }
          },
        ),
      );
      return response.data['status'] as bool;
    } catch (e) {
      return false;
    }
  }
}
