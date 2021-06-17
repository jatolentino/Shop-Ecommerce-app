import 'dart:convert';
import 'package:shop/constants/api_path.dart';
import 'package:shop/module/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  AuthServices._();
  static final AuthServices _instance = AuthServices._();
  static AuthServices get instance => _instance;

  /*<---------------------Register Service--------------------->*/

  Future registerFromApi(String name, String username, String phone,
      String email, String pass) async {
    String url = baseUrl + registerPath;
    final payload = {
      "name": name,
      "username": username,
      "phone": phone,
      "email": email,
      "password": pass
    };
    final header = {"Content-Type": "application/json"};
    print(payload);
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(payload),
        headers: header,
      );
      Map<String, dynamic> responseResult = Map<String, dynamic>();
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        responseResult = {
          "code": response.statusCode,
          "data": responseData['message']
        };
      } else {
        responseResult = {
          "code": response.statusCode,
          "data": responseData['error']
        };
      }
      return responseResult;
    } on Exception catch (e) {
      print(e.toString());
      throw e;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /*<---------------------Login Service--------------------->*/

  Future loginFromApi(String email, String pass) async {
    String url = baseUrl + loginPath;
    final payload = {"email": email, "password": pass};
    final header = {"Content-Type": "application/json"};
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(payload),
        headers: header,
      );
      Map<String, dynamic> responseResult = Map<String, dynamic>();
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        responseResult = {"code": response.statusCode, "data": responseData};
      } else {
        responseResult = {
          "code": response.statusCode,
          "data": responseData['error']
        };
      }
      return responseResult;
    } on Exception catch (e) {
      print(e.toString());
      throw e;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /*<---------------------User Details--------------------->*/
  Future<Map<String, dynamic>> userInfo({@required id}) async {
    String params = "/$id";
    String url = baseUrl + userPath + params;
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Map<String, dynamic>? map;
        if (responseData != null) {
          final result = UserModel.fromJson(responseData);
          map = {'code': response.statusCode, 'data': result};
        }
        return map!;
      } else {
        print("Something went wrong");
        final map = {'code': response.statusCode, 'data': 'error'};
        return map;
      }
    } on Exception catch (e) {
      print(e.toString());
      throw e;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
