class BannerModel {
  String? title;
  String? offerText;
  String? imgUrl;

  BannerModel({this.title, this.offerText, this.imgUrl});

  BannerModel.fromMap(Map<String, dynamic> map) {
    this.title = map['title']!;
    this.offerText = map['subtitle']!;
    this.imgUrl = map['imgUrl']!;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['title'] = this.title;
    map['subtitle'] = this.offerText;
    map['imgUrl'] = this.imgUrl;

    return map;
  }
}
