import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class SpendViewModel extends BaseModel {
  SpendsModel spend = SpendsModel(
    amount: 0.0,
    spendId: null,
    date: null,
    brandId: null,
    brandName: null,
    categoryId: null,
    address: null,
    count: null,
    paymentType: null,
    body: null,
  );

  init(String spendId) async {
    setState(ViewState.busy);
    final result =
        await apiService.getRequest('${ApiConstants.spendInfo}/$spendId');
    if (result.data != null) {
      print(result.data);
      spend = SpendsModel.fromJson(result.data as Map<String, dynamic>);
    }
    setState(ViewState.idle);
  }

  void gotoNotifications() {
    navigationService.showSnackBar('No new notifications');
  }
}
