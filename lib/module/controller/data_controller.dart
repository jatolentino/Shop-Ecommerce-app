import 'package:shop/module/controller/base_controller.dart';
import 'package:shop/module/controller/cart_controller.dart';
import 'package:shop/module/model/my_order_model.dart';
import 'package:shop/module/model/product_model.dart';
import 'package:shop/utils/service/api/product_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DataController extends GetxController with BaseController {
  RxBool isLoading = false.obs;
  RxBool searchLoading = false.obs;
  RxBool detailsLoading = false.obs;
  RxBool orderLoading = false.obs;
  var productData = ProductModel().obs;
  var searchData = ProductModel().obs;
  var productDetails = Products().obs;
  var myOrders = <MyOrderModel>[].obs;
  var errorMsg = "".obs;
  var itemExists = false.obs;
  var wishExists = false.obs;
  final box = GetStorage();
  String? userId;

  @override
  onInit() {
    super.onInit();
    getProductController();
    userId = box.read('id');
    if (userId != null) getMyOrder();
  }

  Future getProductController() async {
    try {
      isLoading(true);
      final result = await ProductService.instance.getAllProduct();
      if (result['code'] == 200) {
        productData.value = result['data'];
      } else {
        errorMsg.value = result['data'];
      }
      update();
    } catch (e) {
      handleError(e);
    } finally {
      isLoading(false);
    }
  }

  Future searchProduct({required type}) async {
    try {
      searchLoading(true);
      final result = await ProductService.instance
          .searchProductService(type: type, page: 1);
      if (result['code'] == 200) {
        searchData.value = result['data'];
      } else {
        errorMsg.value = result['data'];
      }
      update();
    } catch (e) {
      handleError(e);
    } finally {
      searchLoading(false);
    }
  }

  Future getProductDetails({required id}) async {
    CartController cart = Get.find();
    try {
      detailsLoading(true);
      final result = await ProductService.instance.detailsService(id: id);
      if (result['code'] == 200) {
        productDetails.value = result['data'];

        final checkCartItem = cart.cartList
            .where((element) => element.id == productDetails.value.id);

        final checkWishItem = cart.wishList
            .where((element) => element.id == productDetails.value.id);

        if (checkCartItem.isNotEmpty)
          itemExists(true);
        else
          itemExists(false);

        if (checkWishItem.isNotEmpty)
          wishExists(true);
        else
          wishExists(false);
      } else {
        errorMsg.value = result['data'];
      }
      update();
    } catch (e) {
      handleError(e);
    } finally {
      detailsLoading(false);
    }
  }

  Future getMyOrder() async {
    try {
      orderLoading(true);
      final result = await ProductService.instance.orderService(id: userId);
      if (result['code'] == 200) {
        myOrders.assignAll(result['data']);
      } else {
        errorMsg.value = result['data'];
      }
      update();
    } catch (e) {
      handleError(e);
    } finally {
      orderLoading(false);
    }
  }
}
