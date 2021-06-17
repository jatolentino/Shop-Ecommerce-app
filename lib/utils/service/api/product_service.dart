import 'dart:convert';
import 'dart:io';
import 'package:shop/constants/api_path.dart';
import 'package:shop/module/model/my_order_model.dart';
import 'package:shop/module/model/product_model.dart';
import 'package:shop/utils/helper/exception.dart';
import 'package:http/http.dart' as http;

class ProductService {
  ProductService._();
  static final ProductService _instance = ProductService._();
  static ProductService get instance => _instance;

  Future<Map<String, dynamic>> getAllProduct() async {
    String url = baseUrl + productPath;
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("******************************1");
        print(responseData);
        print("******************************1");
        // print(responseData);
        final data = ProductModel.fromJson(responseData);
        final map = {"code": response.statusCode, "data": data};
        print("******************************2");
        print(data);
        print("******************************2");
        return map;
      } else {
        final map = {"code": response.statusCode, "data": response.body};
        return map;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> searchProductService(
      {String? type, int? page}) async {
    String params = "?keyword=$type&pageNumber=$page";
    String url = baseUrl + productPath + params;
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final data = ProductModel.fromJson(responseData);
        final map = {"code": response.statusCode, "data": data};
        return map;
      } else {
        final map = {"code": response.statusCode, "data": response.body};
        return map;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> detailsService({String? id}) async {
    String params = "/fetch-product/$id";
    String url = baseUrl + productPath + params;
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final data = Products.fromJson(responseData['product']);
        print(data.name);
        final map = {"code": response.statusCode, "data": data};

        return map;
      } else {
        final map = {"code": response.statusCode, "data": response.body};
        return map;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> orderService({String? id}) async {
    String params = "/$id";
    String url = baseUrl + orderPath + params;
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final list = <MyOrderModel>[];
        responseData.map((e) => list.add(MyOrderModel.fromJson(e))).toList();
        final map = {"code": response.statusCode, "data": list};

        return map;
      } else {
        final map = {"code": response.statusCode, "data": response.body};
        return map;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on Exception catch (e) {
      throw e;
    }
  }
}
