import 'dart:async';
import 'package:cashback/core/constants/api_constants.dart';
import 'package:cashback/core/network/dio_client.dart';
import 'package:cashback/core/utils/analytics/analytic_events.dart';
import 'package:cashback/core/utils/analytics/analytic_manager.dart';
import 'package:cashback/features/auth/repository/auth_repository.dart';
import 'package:cashback/models/auth/req/sign_in_model.dart';
import 'package:cashback/models/auth/res/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = AutoDisposeAsyncNotifierProvider<AuthController, void>(AuthController.new);

final authStateChanges = StreamProvider((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});
final userProvider = StateProvider<UserModel?>((ref) {
  return;
});

class AuthController extends AutoDisposeAsyncNotifier<void> {
  late Dio _dio;
  @override
  FutureOr<void> build() {
    _dio = ref.read(dioClientProvider).dio;
  }

  Future<void> signInWithGoogle() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final credentials = await authRepository.signInWithGoogle();
      final idToken = await credentials.user?.getIdToken();
      final response = await _dio.post(
        ApiConstants.SIGN_IN_URL,
        data: SignInModel(idToken: idToken ?? "").toJson(),
      );
      ref.read(userProvider.notifier).update((state) => UserModel.fromMap(response.data));
      ref.read(analyticsManagerProvider).logSignUpEventToFirebase(AnalyticsEvent.signInWithGoogle);
    });
  }

  Future<void> signUpWithEmail(String email, String password, String username, String phone) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userCredential = await authRepository.signUpWithEmail(email, password);
      final idToken = await userCredential.user?.getIdToken();
      await _dio.post(ApiConstants.SIGN_IN_URL,
          data: SignInModel(idToken: idToken ?? "", username: username, phone: phone).toJson());
      await getUser();
    });
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userCredential = await authRepository.signInWithEmailAndPassword(email, password);
      final idToken = await userCredential.user?.getIdToken();
      final response = await _dio.post(
        ApiConstants.SIGN_IN_URL,
        data: SignInModel(idToken: idToken ?? "").toJson(),
      );
      ref.read(userProvider.notifier).update((state) => UserModel.fromMap(response.data));
    });
  }

  Future<void> getUser() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final user = await authRepository.getUser(ref);
      ref.read(userProvider.notifier).update((state) => user);
    });
  }

  Future<void> logout() async {
    final authRepository = ref.read(authRepositoryProvider);
    authRepository.logout();
  }

  Future<void> deleteAccount() async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.deleteAccount();
  }
}
