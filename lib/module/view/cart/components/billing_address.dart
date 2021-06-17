import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_constants.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/module/controller/auth_controller.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:shop/module/model/checkout_model.dart';
import 'package:shop/utils/helper/dialog.dart';
import 'package:shop/utils/helper/show_snack.dart';
import 'package:shop/utils/service/payment/payment.dart';
import 'package:shop/widgets/custom_app_bar.dart';
import 'package:shop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BillingAddress extends StatefulWidget {
  @override
  _BillingAddressState createState() => _BillingAddressState();
}

class _BillingAddressState extends State<BillingAddress> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  final firstNameBox = GetStorage();
  final lastNameBox = GetStorage();
  final companyNameBox = GetStorage();
  final phoneBox = GetStorage();
  final countryBox = GetStorage();
  final addressBox = GetStorage();
  final cityBox = GetStorage();
  final zipBox = GetStorage();
  final notesBox = GetStorage();

  @override
  void initState() {
    super.initState();
    firstName.text = firstNameBox.read('first') ?? "";
    //firstName.text = "someone" ?? "";
    lastName.text = lastNameBox.read('last') ?? "";
    companyName.text = companyNameBox.read('company') ?? "";
    address.text = addressBox.read('address') ?? "";
    country.text = countryBox.read('country') ?? "";
    phone.text = phoneBox.read('phone') ?? "";
    city.text = cityBox.read('city') ?? "";
    zipcode.text = zipBox.read('zip') ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    address.dispose();
    phone.dispose();
    city.dispose();
    zipcode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CartController cart = Get.find();

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: ResponsiveSize.screenHeight,
          width: ResponsiveSize.screenWidth,
          child: Column(
            children: [
              AppBarCard(
                childWidget: Row(
                  children: [
                    InkWell(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(
                          backIcon,
                          color: Colors.white,
                        )),
                    getHorizontalSpace(10),
                    Text(
                      "Checkout ",
                      style: TextStyle(
                        fontSize: getTextSize(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: firstName,
                            decoration: buildCredentialDecoration(
                                hintText: "First Name"),
                          ),
                        ),
                        getHorizontalSpace(10),
                        Expanded(
                          child: TextField(
                            controller: lastName,
                            decoration: buildCredentialDecoration(
                                hintText: "Last Name"),
                          ),
                        ),
                      ],
                    ),
                    // getVerticalSpace(10),
                    // TextField(
                    //   controller: companyName,
                    //   decoration:
                    //       buildCredentialDecoration(hintText: "Company Name"),
                    // ),
                    getVerticalSpace(10),

                    TextField(
                      controller: phone,
                      keyboardType: TextInputType.number,
                      cursorColor: kPrimary,
                      decoration: buildCredentialDecoration(hintText: "Phone"),
                    ),
                    getVerticalSpace(10),
                    TextField(
                      controller: country,
                      decoration:
                          buildCredentialDecoration(hintText: "Country"),
                    ),
                    getVerticalSpace(10),
                    TextField(
                      controller: address,
                      decoration:
                          buildCredentialDecoration(hintText: "Address"),
                    ),

                    getVerticalSpace(10),

                    TextField(
                      controller: city,
                      decoration: buildCredentialDecoration(hintText: "City"),
                    ),
                    getVerticalSpace(10),

                    TextField(
                      controller: zipcode,
                      keyboardType: TextInputType.number,
                      decoration:
                          buildCredentialDecoration(hintText: "Post Code"),
                    ),
                    // getVerticalSpace(50),
                  ],
                ),
              ),
              getVerticalSpace(30),
              CustomButton(
                widthValue: getScreeWidth(335),
                text: 'Proceed to Pay',
                press: () {
                  checkout();
                },
                color: kPrimary,
              ),
              getVerticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }

  checkout() async {
    CartController cart = Get.find();
    AuthController auth = Get.find();
    try {
      if (address.text.isNotEmpty &&
          phone.text.isNotEmpty &&
          city.text.isNotEmpty &&
          zipcode.text.isNotEmpty) {
        firstNameBox.write('first', firstName.text);
        lastNameBox.write('last', lastName.text);
        companyNameBox.write('company', companyName.text);
        addressBox.write('address', address.text);
        countryBox.write('country', country.text);
        phoneBox.write('phone', phone.text);
        cityBox.write('city', city.text);
        zipBox.write('zip', zipcode.text);

        cart.checkoutInfo = CheckoutModel(
          userId: auth.userData.value.user!.id,
          firstName: firstName.text,
          lastName: lastName.text,
          companyName: companyName.text,
          email: auth.userData.value.user!.email,
          phone: phone.text,
          country: country.text,
          address: address.text,
          city: city.text,
          postCode: zipcode.text,
          orderNotes: "Good Products",
          totalPrice: cart.cartTotal.toInt(),
          orderItems: cart.cartList,
        );

        payViaCard(amount: cart.cartTotal);
      } else {
        SnackMessage.instance.showSnack(message: "Field can't be empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  payViaCard({@required amount}) async {
    try {
      int _amount = (amount * 100).toInt();
      String totalAmount = _amount.toString();
      DialogHelper.instance.showLoading(message: 'Processing! Please wait.');
      final result = await PaymentService.instance
          .payWithNewCard(amount: totalAmount, currency: 'usd');
      DialogHelper.instance.hideLoading();
      if (result.success!) {
        DialogHelper.instance.orderPlacedDialog();
      } else
        snackMessage(message: result.message);
    } catch (e) {
      print(e.toString());
      DialogHelper.instance.hideLoading();
    }
  }

  void snackMessage({@required message}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
