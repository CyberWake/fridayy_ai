import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenViewModel extends BaseModel {
  UserOverView userOverView = UserOverView(
    user: User(userName: ''),
    offer: Offer(
      notifiedOffers: [],
      offersExpiring: 0,
      totalOffers: 0,
      activeOffers: 0,
    ),
    spending: Spending(month: '', currency: '', amount: 0, distribution: []),
    financial: Financial(percentile: 0),
  );

  Future init() async {
    setState(ViewState.busy);
    final result = await apiService.getRequest(ApiConstants.userOverview);
    if (result != null) {
      userOverView = UserOverView.fromJson(result as Map<String, dynamic>);
      setState(ViewState.idle);
    }
  }

  Future postSms() async {
    final List<Map<String, dynamic>> data = await messageService.readMessage();
    if (data.isNotEmpty) {
      final result = await messageService.postSms(data);
      if (result) {
        init();
      }
    } else {
      init();
    }
  }
}
