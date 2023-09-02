import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderResponseModel {
  final String token;
  final String redirectUrl;
  OrderResponseModel({
    required this.token,
    required this.redirectUrl,
  });

  factory OrderResponseModel.fromMap(Map<String, dynamic> map) {
    return OrderResponseModel(
      token: map['token'] as String,
      redirectUrl: map['redirect_url'] as String,
    );
  }

  factory OrderResponseModel.fromJson(String source) =>
      OrderResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
