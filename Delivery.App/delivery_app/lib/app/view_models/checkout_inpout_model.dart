import 'dart:convert';

class CheckoutInpoutModel {
  int userId;
  String address;
  String paymentType;
  List<int> itemsId;

  CheckoutInpoutModel({
    this.userId,
    this.address,
    this.paymentType,
    this.itemsId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'address': address,
      'paymentType': paymentType,
      'itemsId': itemsId,
    };
  }

  factory CheckoutInpoutModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CheckoutInpoutModel(
      userId: map['userId'],
      address: map['address'],
      paymentType: map['paymentType'],
      itemsId: List<int>.from(map['itemsId']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckoutInpoutModel.fromJson(String source) =>
      CheckoutInpoutModel.fromMap(json.decode(source));
}
