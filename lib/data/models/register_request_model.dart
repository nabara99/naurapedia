import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterRequestModel {
  final String name;
  final String password;
  final String email;
  final String username;
  RegisterRequestModel({
    required this.name,
    required this.password,
    required this.email,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'password': password,
      'email': email,
      'username': username,
    };
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    return RegisterRequestModel(
      name: map['name'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromJson(String source) =>
      RegisterRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
