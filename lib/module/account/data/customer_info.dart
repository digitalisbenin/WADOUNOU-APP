import 'package:digitalis_restaurant_app/core/model/adress/address.dart';

class CustomerInfo {
  CustomerInfo({
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.userName,
    this.addresses,
  });

  CustomerInfo.fromJson(dynamic json) {
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    if (json['addresses'] != null) {
      addresses = [];
      json['addresses'].forEach((v) {
        addresses?.add(Address.fromJson(v));
      });
    }

    if (firstName == null && lastName == null) {
      fullName = "Walk-in";
    } else {
      fullName = '${firstName ?? ''} ${lastName ?? ''}';
    }
  }
  String? email;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? userName;
  String? fullName;
  List<Address>? addresses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['userName'] = userName;
    if (addresses != null) {
      map['addresses'] = addresses?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
