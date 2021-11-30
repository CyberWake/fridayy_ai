import 'dart:async';

import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenViewModel extends BaseModel {
  Timer? timer;
  late HomeScreenHolderViewModel homeModel;

  Future init({
    required bool isAutoLogin,
    required HomeScreenHolderViewModel model,
  }) async {
    homeModel = model;
    if (!isAutoLogin) {
      setState(ViewState.busy);
      await postSms();
    } else {
      setState(ViewState.busy);
      if (homeModel.userOverView == null) {
        await getOverViewExplicitly();
      } else {
        setState(ViewState.idle);
      }
    }
  }

  Future getOverViewExplicitly({bool showDefault = false}) async {
    final result = await apiService.getRequest(ApiConstants.userOverview);
    if (result.data != null) {
      localDatabaseService.saveLastRefresh();
      final userOverView =
          UserOverView.fromJson(result.data as Map<String, dynamic>);
      int radius = 80;
      userOverView.spending.distribution!
          .sort((a, b) => a.percentage.compareTo(b.percentage));
      userOverView.spending.distribution!.reversed.toList().forEach((element) {
        element.radius = radius;
        radius += 3;
      });
      homeModel.shortPolledOverView = userOverView;
      if (userOverView.offers.totalOffers != 0 &&
          homeModel.userOverView == null) {
        homeModel.userOverView = userOverView;
        if (homeModel.currentTabIndex == 0) {
          setState(ViewState.idle);
        }
      }
    } else if (result.exception != null) {
      // setState(ViewState.idle);
    }
  }

  Future postSms() async {
    if (timer == null) {
      final CallOutcome<Map<String, List<Map<String, dynamic>>>> messageData =
          await messageService.readMessage();
      if (messageData.exception == null && messageData.data != null) {
        final CallOutcome<bool> result =
            await messageService.postSms(messageData.data!);
        if (result.exception == null && result.data == true) {
          int i = 0;
          timer = Timer.periodic(const Duration(seconds: 20), (Timer t) {
            if (i == 20) {
              timer!.cancel();
            }
            i++;
            getOverViewExplicitly(showDefault: true);
          });
        } else {
          getOverViewExplicitly(showDefault: true);
        }
      } else {
        getOverViewExplicitly(showDefault: true);
      }
    } else {
      homeModel.userOverView = homeModel.shortPolledOverView;
      setState(ViewState.idle);
    }
  }
}
