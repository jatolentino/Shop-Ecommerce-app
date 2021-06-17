class UserModel {
  User? user;

  UserModel({this.user});

  UserModel.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class User {
  List<dynamic>? orders;
  String? id;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? role;
  String? password;
  int? v;

  User(
      {this.orders,
      this.id,
      this.name,
      this.username,
      this.email,
      this.phone,
      this.role,
      this.password,
      this.v});

  User.fromJson(dynamic json) {
    // if (json['orders'] != null) {
    //   orders = [];
    //   json['orders'].forEach((v) {
    //     orders?.add(dynamic.fromJson(v));
    //   });
    // }
    id = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    password = json['password'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (orders != null) {
      map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    map['_id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['phone'] = phone;
    map['role'] = role;
    map['password'] = password;
    map['__v'] = v;
    return map;
  }
}
