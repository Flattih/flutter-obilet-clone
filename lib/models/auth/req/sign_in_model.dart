import 'dart:convert';

class SignInModel {
  final String idToken;
  final String? username;
  final String phone;

  SignInModel({required this.idToken, this.username, this.phone = ""});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idToken': idToken,
      'username': username,
      'phone': phone,
    };
  }

  factory SignInModel.fromMap(Map<String, dynamic> map) {
    return SignInModel(
      idToken: map['idToken'] as String,
      username: map['username'] != null ? map['username'] as String : null,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInModel.fromJson(String source) => SignInModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
