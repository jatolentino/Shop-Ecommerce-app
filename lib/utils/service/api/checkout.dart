import 'dart:convert';
import 'dart:io';
import 'package:shop/constants/api_path.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:shop/module/controller/data_controller.dart';
import 'package:shop/utils/helper/exception.dart';
import 'package:shop/utils/service/payment/payment.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Checkout {
  Checkout._();
  static final Checkout _instance = Checkout._();
  static Checkout get instance => _instance;

  Future<TransactionResponse> makeCheckout() async {
    CartController cart = Get.find();
    DataController dataCtrl = Get.find();

    String url = baseUrl + makeOrder;
    Uri uri = Uri.parse(url);

    final payload = cart.checkoutInfo.toJson();
    print("---:");
    print(payload);

    Map<String, String> headers = {'Content-Type': 'application/json'};
    try {
      http.Response response = await http.post(
        uri,
        body: json.encode(payload),
        headers: headers,
      );
      print("sc: ${response.statusCode}");

      if (response.statusCode == 200) {
        cart.cartList.clear();
        dataCtrl.getMyOrder();

        return TransactionResponse(
          message: response.body,
          success: true,
        );
      } else {
        return TransactionResponse(
          message: response.body,
          success: false,
        );
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on Exception catch (e) {
      throw e;
    }
  }
}
