import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String username;
  String email;
  String password;

  Users({
    required this.username,
    required this.email,
    required this.password,
  });

  // receiving data from server
  factory Users.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Users(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  // sending data to our server
  Map<String, dynamic> tojson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
