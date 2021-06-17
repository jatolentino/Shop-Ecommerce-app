class ProductModel {
  List<Products>? products;
  int? page;
  int? pages;

  ProductModel({this.products, this.page, this.pages});

  ProductModel.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    page = json['page'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['page'] = page;
    map['pages'] = pages;
    return map;
  }
}

class Products {
  String? id;
  String? name;
  String? description;
  String? type;
  String? images;
  String? imagePublicId;
  int? price;
  String? color;
  List<dynamic>? reviews;
  int? totalInStock;
  String? createdAt;
  int? v;

  Products(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.images,
      this.imagePublicId,
      this.price,
      this.color,
      this.reviews,
      this.totalInStock,
      this.createdAt,
      this.v});

  Products.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    images = json['images'];
    imagePublicId = json['image_public_id'];
    price = int.parse(json['price']);
    color = json['color'];
    // if (json['reviews'] != null) {
    //   reviews = [];
    //   json['reviews'].forEach((v) {
    //     reviews?.add(dynamic.fromJson(v));
    //   });
    // }
    totalInStock = json['total_in_stock'];
    createdAt = json['createdAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['type'] = type;
    map['images'] = images;
    map['image_public_id'] = imagePublicId;
    map['price'] = price;
    map['color'] = color;
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    map['total_in_stock'] = totalInStock;
    map['createdAt'] = createdAt;
    map['__v'] = v;
    return map;
  }
}
