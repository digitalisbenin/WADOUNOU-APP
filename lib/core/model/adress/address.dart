/// _id : "637ff4c9dcf66230c0d95746"
/// country : "Bénin"
/// city : "Cotono"
/// zipCode : 1234
/// state : "kpota"
/// address : "Cotonou,Benin"
/// addressNumber : 111

class Address {
  Address({
    this.id,
    this.addressNumber,
    this.isPrimary,
    this.country,
    this.address,
    this.city,
    this.state,
    this.zipCode,
  });

  Address.fromJson(dynamic json) {
    id = json['_id'];
    addressNumber = json['addressNumber'];
    isPrimary = json['isPrimary'];
    country = json['country'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    zipCode = json['zipCode'];
  }
  String? id;
  dynamic addressNumber;
  bool? isPrimary;
  String? country;
  String? address;
  String? city;
  String? state;
  double? latitude;
  double? longitude;
  int? zipCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['addressNumber'] = addressNumber;
    map['isPrimary'] = isPrimary;
    map['country'] = country;
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['zipCode'] = zipCode;
    return map;
  }
}
