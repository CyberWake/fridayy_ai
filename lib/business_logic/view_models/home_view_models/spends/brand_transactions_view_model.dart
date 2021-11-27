import 'package:fridayy_one/business_logic/models/spend_on_brand_model.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class BrandTransactionsViewModel extends BaseModel {
  SpendsOnBrand brandSpendData = SpendsOnBrand(
    totalSpend: 0.0,
    currency: 'Rs',
    brandId: '',
    brandName: '',
    spends: [],
  );
  late String id;
  late String filter;

  init(String brandId, String month) {
    id = brandId;
    filter = month;
    getSpendingOnBrand();
  }

  Future getSpendingOnBrand() async {
    setState(ViewState.busy);
    print('${ApiConstants.spendingOnBrand}/$id?month=$filter');
    final result = await apiService
        .getRequest('${ApiConstants.spendingOnBrand}/$id?month=$filter');
    if (result.data != null) {
      brandSpendData =
          SpendsOnBrand.fromJson(result.data as Map<String, dynamic>);
    }
    setState(ViewState.idle);
  }

  void gotoNotifications() {
    navigationService.showSnackBar('No new notifications');
  }
}
