import 'package:cashback/core/constants/api_constants.dart';
import 'package:cashback/core/network/dio_client.dart';
import 'package:cashback/core/providers/firebase_providers.dart';
import 'package:cashback/models/auth/res/user_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
    dio: ref.read(dioClientProvider).dio,
  );
});

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final Dio _dio;

  AuthRepository({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required Dio dio,
  })  : _auth = auth,
        _googleSignIn = googleSignIn,
        _dio = dio;

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return _auth.signInWithCredential(credential);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel> getUser(AutoDisposeAsyncNotifierProviderRef ref) async {
    try {
      final response = await _dio.get(ApiConstants.GET_USER_URL);
      return UserModel.fromMap(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    user?.delete();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
