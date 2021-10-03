import 'package:fridayy_one/business_login/models/spending_brands_model.dart';
import 'package:fridayy_one/business_login/models/spending_category_model.dart';
import 'package:fridayy_one/business_login/models/spending_transaction_model.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class SpendingScreenViewModel extends BaseModel {
  final String title = "Spending Analysis";
  late SpendingTransactionModel data;
  final List<SpendingCategoryModel> spendCategoryData = [];
  final List<SpendingBrandModel> spendBrandData = [];

  final List<Distribution> categoryData = [
    Distribution(categoryId: "FAD", percentage: 3.1),
    Distribution(categoryId: "MDCL", percentage: 4.9),
    Distribution(categoryId: "UTL", percentage: 42.9),
    Distribution(categoryId: "TRVL", percentage: 18.4),
    Distribution(categoryId: "LUX", percentage: 0.0),
    Distribution(categoryId: "FIN", percentage: 30.7),
    Distribution(categoryId: "OTH", percentage: 0.9),
    Distribution(categoryId: "EAD", percentage: 0.0),
  ];

  final List<List> dataCategory = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];

  init() async {
    setState(ViewState.busy);
    await getTransactionData();
    await getCategoryData();
    await getBrandData();
    setState(ViewState.idle);
  }

  Future getTransactionData() async {
    final resultSpendingTransactions = await apiService
        .getRequest("${ApiConstants.spendingTransactions}/2109");
    if (resultSpendingTransactions != null) {
      print(resultSpendingTransactions);
      data = SpendingTransactionModel.fromJson(
        resultSpendingTransactions as Map<String, dynamic>,
      );
    } else {
      data = SpendingTransactionModel(amount: 0.0, count: 0, spends: []);
    }
  }

  Future getCategoryData() async {
    final result = await apiService.getRequest(
      "${ApiConstants.spendingCategory}/?date=2109",
    );
    if (result != null) {
      (result['result'] as List).forEach((element) {
        spendCategoryData.add(
          SpendingCategoryModel.fromJson(element as Map<String, dynamic>),
        );
      });
    }
  }

  Future getBrandData() async {
    final result =
        await apiService.getRequest('${ApiConstants.spendingBrand}?date=2109');
    if (result != null) {
      (result['result'] as List).forEach((element) {
        spendBrandData
            .add(SpendingBrandModel.fromJson(element as Map<String, dynamic>));
      });
    }
  }
}
