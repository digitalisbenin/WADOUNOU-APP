import 'customer_info.dart';

class Customer {
  Customer({
    this.userId,
    this.enabled,
    this.visitCount,
    this.reservationCount,
    this.waitListCount,
    this.walkInCount,
    this.cancellationCount,
    this.orderCount,
    this.largeOrder,
    this.id,
    this.customerInfo,
    this.accountGUID,
    this.restaurant,
    this.firstVisitAt,
    this.lastVisitAt,
    this.createdDate,
    this.v,
  });

  Customer.fromJson(dynamic json) {
    enabled = json['enabled'];
    userId = json['user'];
    visitCount = json['visitCount'];
    reservationCount = json['reservationCount'];
    waitListCount = json['waitListCount'];
    walkInCount = json['walkInCount'];
    cancellationCount = json['cancellationCount'];
    orderCount = json['orderCount'];
    largeOrder = json['largeOrder'];
    id = json['_id'];
    customerInfo = json['customerInfo'] != null
        ? CustomerInfo.fromJson(json['customerInfo'])
        : null;
    accountGUID = json['accountGUID'];
    restaurant = json['restaurant'];
    firstVisitAt = json['firstVisitAt'];
    lastVisitAt = json['lastVisitAt'];
    createdDate = json['createdDate'];
    v = json['__v'];
  }

  bool? enabled;
  num? visitCount;
  num? reservationCount;
  num? waitListCount;
  num? walkInCount;
  num? cancellationCount;
  num? orderCount;
  num? largeOrder;
  String? id;
  String? userId;
  CustomerInfo? customerInfo;
  String? accountGUID;
  String? restaurant;
  String? firstVisitAt;
  String? lastVisitAt;
  String? createdDate;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = enabled;
    map['visitCount'] = visitCount;
    map['reservationCount'] = reservationCount;
    map['waitListCount'] = waitListCount;
    map['walkInCount'] = walkInCount;
    map['cancellationCount'] = cancellationCount;
    map['orderCount'] = orderCount;
    map['largeOrder'] = largeOrder;
    map['_id'] = id;
    map['userId'] = userId;
    if (customerInfo != null) {
      map['customerInfo'] = customerInfo?.toJson();
    }
    map['accountGUID'] = accountGUID;
    map['restaurant'] = restaurant;
    map['firstVisitAt'] = firstVisitAt;
    map['lastVisitAt'] = lastVisitAt;
    map['createdDate'] = createdDate;
    map['__v'] = v;
    return map;
  }
}
