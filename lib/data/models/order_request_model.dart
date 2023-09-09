// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderRequestModel {
  final Data data;

  OrderRequestModel({
    required this.data,
  });

  factory OrderRequestModel.fromRawJson(String str) =>
      OrderRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) =>
      OrderRequestModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final List<Item> items;
  final int totalPrice;
  final String deliveryAddress;
  final String courierName;
  final int shippingCost;
  final String statusOrder;
  final int userId;

  Data({
    required this.items,
    required this.totalPrice,
    required this.deliveryAddress,
    required this.courierName,
    required this.shippingCost,
    required this.statusOrder,
    required this.userId,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalPrice: json["totalPrice"],
        deliveryAddress: json["deliveryAddress"],
        courierName: json["courierName"],
        shippingCost: json["shippingCost"],
        statusOrder: json["statusOrder"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "deliveryAddress": deliveryAddress,
        "courierName": courierName,
        "shippingCost": shippingCost,
        "statusOrder": statusOrder,
        "userId": userId,
      };
}

class Item {
  final int id;
  final String productname;
  final int price;
  final int qyt;

  Item({
    required this.id,
    required this.productname,
    required this.price,
    required this.qyt,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        productname: json["productname"],
        price: json["price"],
        qyt: json["qyt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productname": productname,
        "price": price,
        "qyt": qyt,
      };
}
