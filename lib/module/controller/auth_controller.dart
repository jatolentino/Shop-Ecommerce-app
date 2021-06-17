import 'package:shop/module/controller/app_controller.dart';
import 'package:shop/module/model/user_model.dart';
import 'package:shop/utils/service/api/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var token = "".obs;
  var userId = "".obs;
  var errorMsg = "".obs;
  var userData = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    if (userId.isNotEmpty) userDataCtrl();
  }

  /*<---------------------Register--------------------->*/

  Future<bool> userRegister(
      {@required name,
      @required username,
      @required phone,
      @required email,
      @required pass}) async {
    try {
      isLoading(true);
      final result = await AuthServices.instance
          .registerFromApi(name, username, phone, email, pass);
      if (result['code'] == 200) {
        return true;
      } else {
        this.errorMsg.value = result['data'];
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    } finally {
      isLoading(false);
    }
  }

  /*<---------------------Login--------------------->*/

  Future<bool> userLogin({@required email, @required pass}) async {
    AppController appCtrl = Get.find();
    try {
      isLoading(true);
      final result = await AuthServices.instance.loginFromApi(email, pass);
      if (result['code'] == 200) {
        final tokenBox = GetStorage();
        final id = GetStorage();
        id.write('id', result['data']['id']);
        tokenBox.write('token', result['data']['token']);
        appCtrl.checkToken();
        update();
        return true;
      } else {
        this.errorMsg.value = result['data'];
        update();
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    } finally {
      isLoading(false);
    }
  }

  /*<---------------------User Details--------------------->*/

  Future<void> userDataCtrl() async {
    try {
      isLoading(true);
      final result =
          await AuthServices.instance.userInfo(id: this.userId.value);
      if (result['code'] == 200) {
        this.userData.value = result['data'];
      } else {
        this.errorMsg.value = result['data'];
      }
      update();
    } catch (e) {
      print(e.toString());
      throw e;
    } finally {
      isLoading(false);
    }
  }
}
