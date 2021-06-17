import 'package:shop/module/controller/data_controller.dart';
import 'package:shop/module/model/checkout_model.dart';
import 'package:shop/module/model/product_model.dart';
import 'package:shop/utils/helper/show_snack.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxBool cartLoading = false.obs;
  var cartList = <CartListItems>[].obs;
  var wishList = <CartListItems>[].obs;
  var checkoutInfo = CheckoutModel();
  RxInt qty = 1.obs;
  DataController dataCtrl = Get.find();
  double get cartTotal => cartList.fold(
      0.0, (sum, element) => sum + element.quantity! * element.price!);

  addToCart(Products item) {
    try {
      final data = item.toJson();
      dataCtrl.itemExists(true);
      cartList.add(CartListItems.fromJson(data, 1));
      final v = wishList.where((e) => e.id == item.id);
      if (v.isNotEmpty) removeFromWish(item.id!);
      SnackMessage.instance.showSnack(message: 'Item added to cart');

      update();
    } catch (e) {
      print(e);
    }
  }

  addToWish(Products item) {
    try {
      final data = item.toJson();
      wishList.add(CartListItems.fromJson(data, 1));
      dataCtrl.wishExists(true);
      // SnackMessage.instance.showSnack(message: 'Added to wish-list');

      update();
    } catch (e) {
      print(e);
    }
  }

  increment(int i) {
    final v = cartList[i].quantity! + 1;
    cartList[i].quantity = v;
    cartList.refresh();
    // update();
  }

  decrement(int i) {
    final v = cartList[i].quantity! - 1;
    cartList[i].quantity = v;
    cartList.refresh();
    // update();
  }

  removeFromCart(int index) {
    cartList.removeAt(index);
    SnackMessage.instance.showSnack(message: 'Removed');
    update();
  }

  removeFromWish(String id) {
    wishList.removeWhere((element) => element.id == id);
    dataCtrl.wishExists(false);
    // SnackMessage.instance.showSnack(message: 'Removed');
    update();
  }

  addToCartFromWish(int index) {
    cartList.add(wishList[index]);
    wishList.removeAt(index);
    SnackMessage.instance.showSnack(message: 'Item added to cart');
    update();
  }
}
