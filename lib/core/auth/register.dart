import 'package:shop/config/routes/app_route.dart';
import 'package:shop/constants/app_color.dart';
import 'package:shop/constants/app_constants.dart';
import 'package:shop/constants/assets_path.dart';
import 'package:shop/constants/size.dart';
import 'package:shop/core/auth/login.dart';
import 'package:shop/module/controller/auth_controller.dart';
import 'package:shop/utils/helper/show_snack.dart';
import 'package:shop/widgets/account_text.dart';
import 'package:shop/widgets/custom_button.dart';
import 'package:shop/widgets/heading_text.dart';
import 'package:shop/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late AuthController auth;
  TextEditingController _name = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  @override
  void initState() {
    super.initState();
    auth = Get.find();
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _username.dispose();
    _phone.dispose();
    _email.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(backIcon),
          onPressed: () => Get.back(),
        ),
        title: Text("Account"),
        backgroundColor: kPrimary,
        elevation: 0.0,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            height: ResponsiveSize.screenHeight * 0.8,
            width: ResponsiveSize.screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.15),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // getVerticalSpace(20),
                        AuthHeadingText(text: "Sign Up", fontSize: 30),
                        getVerticalSpace(30),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _name,
                                decoration: buildCredentialDecoration(
                                    hintText: "Name", icon: nameIcon),
                              ),
                            ),
                            getHorizontalSpace(5),
                            Expanded(
                              child: TextField(
                                controller: _username,
                                decoration: buildCredentialDecoration(
                                    hintText: "User Name", icon: usernameIcon),
                              ),
                            ),
                          ],
                        ),
                        getVerticalSpace(20),
                        TextField(
                          controller: _phone,
                          keyboardType: TextInputType.number,
                          decoration: buildCredentialDecoration(
                              hintText: "Phone No", icon: phoneIcon),
                        ),
                        getVerticalSpace(20),
                        TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: buildCredentialDecoration(
                              hintText: "Email", icon: emailIcon),
                        ),
                        getVerticalSpace(20),
                        TextField(
                          controller: _pass,
                          obscureText: true,
                          decoration: buildCredentialDecoration(
                              hintText: "Password", icon: lockIcon),
                        ),
                        getVerticalSpace(30),
                        if (auth.isLoading.value)
                          LoadingIndicator()
                        else
                          CustomButton(
                            text: "Sign Up Now",
                            widthValue: 335,
                            press: _onRegister,
                          ),
                      ],
                    ),
                  ),
                ),
                getVerticalSpace(30),
                AccountText(
                  text: "Already Have An Account",
                  authText: "Sign In",
                  press: () => Get.offAndToNamed(AppRoute.loginPage),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _onRegister() async {
    if (_name.text.isNotEmpty &&
        _username.text.isNotEmpty &&
        _phone.text.isNotEmpty &&
        _email.text.isNotEmpty &&
        _pass.text.isNotEmpty) {
      try {
        final result = await auth.userRegister(
          name: _name.text,
          username: _username.text,
          phone: _phone.text,
          email: _email.text,
          pass: _pass.text,
        );

        if (result) {
          Get.off(() => LoginPage());
        } else {
          SnackMessage.instance.showSnack(message: auth.errorMsg.value);
        }
      } catch (e) {
        SnackMessage.instance.showSnack(message: e.toString());
      }
    } else {
      print("Field are empty");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Field can't be empty")));
    }
  }
}
