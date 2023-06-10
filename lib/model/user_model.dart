import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserMdl {
  String name;
  String email;
  String uId;
  UserMdl({
    required this.name,
    required this.email,
    required this.uId,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
    };
  }

  factory UserMdl.fromMap(Map<String, dynamic> map) {
    return UserMdl(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uId: map['uId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserMdl.fromJson(String source) => UserMdl.fromMap(json.decode(source));

  static UserMdl? fromFirebaseUser(User user) {}
}
