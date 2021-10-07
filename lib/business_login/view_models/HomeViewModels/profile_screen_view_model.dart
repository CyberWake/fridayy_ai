import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class ProfileScreenViewModel extends BaseModel {
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

  init() async {
    setState(ViewState.busy);
    final result = await apiService.getRequest(ApiConstants.userOverview);
    if (result != null) {
      userOverView = UserOverView.fromJson(result as Map<String, dynamic>);
      setState(ViewState.idle);
    }
  }
}
