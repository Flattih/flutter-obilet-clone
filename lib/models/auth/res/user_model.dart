class UserModel {
  final String username;
  final String email;
  final String uid;
  final String phone;
  UserModel({
    required this.username,
    required this.email,
    required this.uid,
    required this.phone,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? uid,
    String? phone,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'uid': uid,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      phone: map['phone'] as String,
    );
  }

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, uid: $uid, phone: $phone)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username && other.email == email && other.uid == uid && other.phone == phone;
  }

  @override
  int get hashCode {
    return username.hashCode ^ email.hashCode ^ uid.hashCode ^ phone.hashCode;
  }
}
