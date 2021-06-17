import 'package:shop/utils/helper/dialog.dart';
import 'package:shop/utils/helper/exception.dart';

class BaseController {
  void handleError(error) {
    // hideLoading();
    if (error is BadRequestException) {
      var message = error.message;
      DialogHelper.instance.showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.instance.showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.instance.showErrorDialog(description: 'Not Responding');
    }
  }

  showLoading([String? message]) {
    DialogHelper.instance.showLoading(message: message);
  }

  hideLoading() {
    DialogHelper.instance.hideLoading();
  }
}
