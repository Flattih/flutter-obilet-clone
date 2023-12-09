import 'package:cashback/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) => Dio());
final dioClientProvider = Provider<DioClient>((ref) => DioClient(ref.read(dioProvider), ref));

class DioClient {
  final Dio dio;
  final Ref ref;

  DioClient(this.dio, this.ref) {
    dio.options.baseUrl = ApiConstants.BASE_URL;
    dio.options.connectTimeout = const Duration(seconds: 3);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
          options.headers.addAll({"Authorization": idToken});
          return handler.next(options);
        },
        onError: (e, handler) {
          final errorMessage = e.response?.data?["message"] ?? e.message;
          handler.next(
            DioException(
              requestOptions: e.requestOptions,
              message: errorMessage,
              response: e.response,
              type: e.type,
            ),
          );
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
  }
}
