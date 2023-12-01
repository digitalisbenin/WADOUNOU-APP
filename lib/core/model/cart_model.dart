class CartModel {

  late final int? id;
  final String? productId;
  final String? productName;
  final double? initialPrice;
  final double? productPrice;
  final int? quantity;
  final String? description;
  final String? image;

  CartModel({
    required this.id ,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.quantity,
    required this.description,
    required this.image
  });

  CartModel.fromMap(Map<dynamic , dynamic>  data)
      : id = data['id'],
        productId = data["productId"],
        productName = data["productName"],
        initialPrice = data["initialPrice"] is int ? (data["initialPrice"] as int).toDouble() : data["initialPrice"],
        productPrice = data["productPrice"] is int ? (data["productPrice"] as int).toDouble() : data["productPrice"],
        quantity = data["quantity"],
        description = data["description"],
        image = data["image"];

  Map<String, Object?> toMap(){
    return {
      'id' : id ,
      'productId' : productId,
      'productName' :productName,
      'initialPrice' : initialPrice,
      'productPrice' : productPrice,
      'quantity' : quantity,
      'description' : description,
      'image' : image,
    };
  }
}