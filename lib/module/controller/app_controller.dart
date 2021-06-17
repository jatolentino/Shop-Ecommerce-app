import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'auth_controller.dart';

class AppController extends GetxController {
  RxInt navBarIndex = 0.obs;
  RxBool enableScrollerButton = false.obs;
  RxInt categoryIndex = 0.obs;
  RxInt productIndex = 0.obs;
  // ScrollController scrollController = ScrollController();
  CarouselController carousalController = CarouselController();
  RxInt carousalIndex = 0.obs;
  RxInt detailTabIndex = 0.obs;
  PageController appPageCtrl =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  PageController categoryPageCtrl = PageController();
  PageController productPageCtrl = PageController();
  ScrollController homeScrollCtrl = ScrollController();
  ScrollController detailsPageScrollCtrl = ScrollController();
  RxBool userExists = false.obs;
  RxBool showScrollUp = false.obs;
  RxBool isRememberUer = false.obs;
  var flashEndTime =
      DateTime.now().add(new Duration(days: 2)).millisecondsSinceEpoch;
  @override
  void onInit() {
    super.onInit();
    checkToken();
    homeScrollCtrl.addListener(listen);
  }

  listen() {
    // print(scrollCtrl.position.pixels);
    if (homeScrollCtrl.position.pixels > 400) {
      showScrollUp(true);
    } else {
      showScrollUp(false);
    }
    update();
  }

  checkToken() {
    AuthController auth = Get.find();
    final box = GetStorage();
    // final rememberBox = GetStorage();
    final _token = box.read('token');
    final _id = box.read('id');
    // isRememberUer.value = rememberBox.read('remember') ?? false;
    if (_token != null && _id != null) {
      auth.userId.value = _id.toString();
      auth.token.value = _token.toString();
      auth.userDataCtrl();
      userExists(true);
    } else {
      userExists(false);
    }
  }

  scrollUp() {
    homeScrollCtrl.animateTo(0, duration: 500.milliseconds, curve: Curves.ease);
  }

  changePage(int v) {
    navBarIndex(v);
    appPageCtrl.animateToPage(navBarIndex.value,
        duration: 300.milliseconds, curve: Curves.ease);
  }

  changeCategoryPage(int v) {
    categoryIndex.value = v;
    categoryPageCtrl.animateToPage(categoryIndex.value,
        duration: 1.seconds, curve: Curves.ease);
  }

  changeProductPage(int v) {
    productIndex.value = v;
    productPageCtrl.animateToPage(productIndex.value,
        duration: 500.milliseconds, curve: Curves.ease);
  }

  detailPageScroll() {
    detailsPageScrollCtrl.animateTo(0,
        duration: 500.milliseconds, curve: Curves.linear);
  }
}
