import 'dart:convert';

import 'package:shop/utils/service/api/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class TransactionResponse {
  String? message;
  bool? success;
  TransactionResponse({this.message, this.success});
}

String stripeBaseUrl = "https://api.stripe.com/v1";
String paymentApi = "$stripeBaseUrl/payment_intents";
String _secretKey =
    "sk_test_51IiF1SCchAAd9IUU4Vf50h2Ps9KQcA6S8AJFWvtvkZLd7YKx2n5EfQzQWOG5v8oNMQy40Pye9rzbfshSCFtb9IUH00EQCTJHlS";
String _publishableKey =
    "pk_test_51IiF1SCchAAd9IUU01ifKTszStCbroodG5VCivqq8hbPcKlfWcgpacc7fuuNxRWLqV4kQ9Jp4cPfs09fYQArULKY00n86nl0cb";

class PaymentService {
  PaymentService._();
  static final PaymentService _instance = PaymentService._();
  static PaymentService get instance => _instance;

  init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: _publishableKey,
        merchantId: "Test",
        androidPayMode: "test",
      ),
    );
  }

  Future<TransactionResponse> payWithNewCard(
      {@required amount, @required currency}) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );

      final paymentIntent = await createPaymentIntent(amount, currency);
      final paymentConfirm = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id,
        ),
      );

      print(paymentConfirm.status);
      if (paymentConfirm.status == "succeeded") {
        print('succeeded');
        final checkoutResponse = await Checkout.instance.makeCheckout();
        return checkoutResponse;
      } else {
        print(paymentConfirm.status);
        return TransactionResponse(
          message: "Transaction failed",
          success: false,
        );
      }
    } on PlatformException catch (e) {
      return _getPlatformError(e);
    } catch (e) {
      print(e.toString());
      return TransactionResponse(
        message: "Transaction failed",
        success: false,
      );
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(paymentApi), body: {
        "amount": amount,
        "currency": currency,
        "payment_method_types[]": "card"
      }, headers: {
        "Authorization": "Bearer $_secretKey",
        "Content-Type": 'application/x-www-form-urlencoded'
      });

      return jsonDecode(response.body);
    } on Exception catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
    return {"tset": "test"};
  }

  TransactionResponse _getPlatformError(err) {
    print("Platform error: $err");
    String message = "Something went wrong";
    if (err.code == "cancelled") {
      message = "Transaction cancelled";
    }
    return TransactionResponse(
      message: message,
      success: false,
    );
  }
}
