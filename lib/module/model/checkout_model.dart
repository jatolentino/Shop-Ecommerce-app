class CheckoutModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? companyName;
  String? email;
  String? phone;
  String? country;
  String? address;
  String? city;
  String? postCode;
  String? orderNotes;
  int? totalPrice;
  List<CartListItems>? orderItems;

  CheckoutModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.companyName,
      this.email,
      this.phone,
      this.country,
      this.address,
      this.city,
      this.postCode,
      this.orderNotes,
      this.totalPrice,
      this.orderItems});

  CheckoutModel.fromJson(dynamic json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    companyName = json['companyName'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    address = json['address'];
    city = json['city'];
    postCode = json['postCode'];
    orderNotes = json['orderNotes'];
    totalPrice = json['totalPrice'];
    if (json['orderItems'] != null) {
      orderItems = [];
      json['orderItems'].forEach((v) {
        orderItems?.add(CartListItems.fromJson(v, v.quantity));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['userId'] = userId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['companyName'] = companyName;
    map['email'] = email;
    map['phone'] = phone;
    map['country'] = country;
    map['address'] = address;
    map['city'] = city;
    map['postCode'] = postCode;
    map['orderNotes'] = orderNotes;
    map['totalPrice'] = totalPrice;
    if (orderItems != null) {
      map['orderItems'] = orderItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CartListItems {
  String? id;
  String? name;
  int? quantity;
  String? imagePublicId;
  int? price;

  CartListItems.fromJson(dynamic json, int qty) {
    this.id = json['_id'];
    this.name = json['name'];
    this.quantity = qty;
    this.imagePublicId = json['image_public_id'];
    this.price = json['price'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['quantity'] = quantity;
    map['image_public_id'] = imagePublicId;
    map['price'] = price;
    return map;
  }
}
