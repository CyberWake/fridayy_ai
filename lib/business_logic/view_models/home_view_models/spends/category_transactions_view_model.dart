import 'package:fridayy_one/business_logic/models/spend_on_category.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class CategoryTransactionsViewModel extends BaseModel {
  SpendsOnCategory brandSpendData = SpendsOnCategory(
    totalSpend: 0.0,
    currency: 'Rs',
    spends: [],
  );
  late String id;
  late String filter;

  init(String brandId, String month) {
    id = brandId;
    filter = month;
    getSpendingOnCategory();
  }

  Future getSpendingOnCategory() async {
    setState(ViewState.busy);
    print('${ApiConstants.spendingOnCategory}/$id?month=$filter');
    final result = await apiService
        .getRequest('${ApiConstants.spendingOnCategory}/$id?month=$filter');
    if (result.data != null) {
      brandSpendData =
          SpendsOnCategory.fromJson(result.data as Map<String, dynamic>);
    }
    setState(ViewState.idle);
  }

  void gotoNotifications() {
    navigationService.showSnackBar('No new notifications');
  }
}
