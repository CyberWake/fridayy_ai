import 'package:fridayy_one/business_login/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenViewModel extends BaseModel {
  UserOverView userOverView = UserOverView(
    user: User(userName: ' '),
    offer: Offer(
      notifiedOffers: [],
      offersExpiring: 0,
      totalOffers: 0,
      activeOffers: 0,
    ),
    spending: Spending(month: '', currency: '', amount: 0, distribution: []),
    financial: Financial(percentile: 0),
  );

  Future init({required bool isAutoLogin}) async {
    if (!isAutoLogin) {
      await postSms();
    } else {
      setState(ViewState.busy);
      await getOverViewExplicitly();
    }
  }

  Future getOverViewExplicitly() async {
    final result = await apiService.getRequest(ApiConstants.userOverview);
    if (result.data != null) {
      userOverView = UserOverView.fromJson(result.data as Map<String, dynamic>);
      setState(ViewState.idle);
    }
  }

  Future postSms() async {
    setState(ViewState.busy);
    final CallOutcome<String> messageData = await messageService.readMessage();
    if (messageData.data != null) {
      final CallOutcome<bool> result =
          await messageService.postSms(messageData.data!);
      if (result.exception == null) {
        userOverView = messageService.userOverView;
      } else {
        getOverViewExplicitly();
      }
      setState(ViewState.idle);
    } else {
      getOverViewExplicitly();
    }
  }
}
