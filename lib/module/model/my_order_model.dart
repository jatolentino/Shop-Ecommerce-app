class MyOrderModel {
  int? totalPrice;
  bool? isPaid;
  bool? isDelivered;
  String? id;
  String? userId;
  String? userFirstName;
  String? userLastName;
  String? companyName;
  String? userEmail;
  String? userPhone;
  String? userCountry;
  String? userAddress;
  String? userCity;
  String? userPostcode;
  String? userOrderNotes;
  List<OrderItems>? orderItems;
  int? v;

  MyOrderModel({
      this.totalPrice, 
      this.isPaid, 
      this.isDelivered, 
      this.id, 
      this.userId, 
      this.userFirstName, 
      this.userLastName, 
      this.companyName, 
      this.userEmail, 
      this.userPhone, 
      this.userCountry, 
      this.userAddress, 
      this.userCity, 
      this.userPostcode, 
      this.userOrderNotes, 
      this.orderItems, 
      this.v});

  MyOrderModel.fromJson(dynamic json) {
    totalPrice = json['totalPrice'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    id = json['_id'];
    userId = json['userId'];
    userFirstName = json['user_first_name'];
    userLastName = json['user_last_name'];
    companyName = json['company_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userCountry = json['user_country'];
    userAddress = json['user_address'];
    userCity = json['user_city'];
    userPostcode = json['user_postcode'];
    userOrderNotes = json['user_order_notes'];
    if (json['orderItems'] != null) {
      orderItems = [];
      json['orderItems'].forEach((v) {
        orderItems?.add(OrderItems.fromJson(v));
      });
    }
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['totalPrice'] = totalPrice;
    map['isPaid'] = isPaid;
    map['isDelivered'] = isDelivered;
    map['_id'] = id;
    map['userId'] = userId;
    map['user_first_name'] = userFirstName;
    map['user_last_name'] = userLastName;
    map['company_name'] = companyName;
    map['user_email'] = userEmail;
    map['user_phone'] = userPhone;
    map['user_country'] = userCountry;
    map['user_address'] = userAddress;
    map['user_city'] = userCity;
    map['user_postcode'] = userPostcode;
    map['user_order_notes'] = userOrderNotes;
    if (orderItems != null) {
      map['orderItems'] = orderItems?.map((v) => v.toJson()).toList();
    }
    map['__v'] = v;
    return map;
  }

}

class OrderItems {
  String? id;
  String? name;
  int? quantity;
  String? imagePublicId;
  int? price;

  OrderItems({
      this.id, 
      this.name, 
      this.quantity, 
      this.imagePublicId, 
      this.price});

  OrderItems.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    quantity = json['quantity'];
    imagePublicId = json['image_public_id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['quantity'] = quantity;
    map['image_public_id'] = imagePublicId;
    map['price'] = price;
    return map;
  }

}