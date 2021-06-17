class Category {
  String? title;
  String? icon;
  String? activeIcon;
  Category({this.title, this.icon, this.activeIcon});

  Category.fromMap(Map<String, String> map) {
    this.title = map['title'];
    this.icon = map['icon'];
    this.activeIcon = map['active'];
  }

  Map<String, String> toMap() {
    Map<String, String> data = Map<String, String>();
    data['title'] = this.title!;
    data['icon'] = this.icon!;
    data['active'] = this.icon!;
    return data;
  }
}

class CategoryModel {
  String? title;
  String? image;
  double? price;
  CategoryModel({this.title, this.image, this.price});

  CategoryModel.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.image = map['image'];
    this.price = map['price'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title!;
    data['image'] = this.image!;
    data['price'] = this.price!;
    return data;
  }
}
