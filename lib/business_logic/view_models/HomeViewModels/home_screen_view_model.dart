import 'dart:async';

import 'package:fridayy_one/business_logic/models/new_models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/dummy_data.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class HomeScreenViewModel extends BaseModel {
  NewUserOverView? userOverView;
  Timer? timer;

  Future init({required bool isAutoLogin}) async {
    if (!isAutoLogin) {
      await postSms();
    } else {
      setState(ViewState.busy);
      await getOverViewExplicitly();
    }
  }

  Future getOverViewExplicitly({bool showDefault = false}) async {
    final result = await apiService.getRequest(ApiConstants.userOverview);
    if (result.data != null) {
      print(result.data);
      userOverView =
          NewUserOverView.fromJson(result.data as Map<String, dynamic>);
      int radius = 80;
      userOverView!.spending.distribution!.reversed.toList().forEach((element) {
        element.radius = radius;
        radius += 5;
      });
      if (userOverView!.offers.totalOffers > 0 || showDefault) {
        setState(ViewState.idle);
      }
    } else if (result.exception != null) {
      print(result.exception);
      userOverView = NewUserOverView.fromJson(userOverviewDummy);
      int radius = 80;
      userOverView!.spending.distribution!.reversed.toList().forEach((element) {
        element.radius = radius;
        radius += 5;
      });
      setState(ViewState.idle);
    }
  }

  Future postSms() async {
    setState(ViewState.busy);
    if (timer == null) {
      final CallOutcome<List<Map<String, String>>> messageData =
          await messageService.readMessage();
      if (messageData.exception == null && messageData.data != null) {
        print(messageData.data);
        final CallOutcome<bool> result =
            await messageService.postSms(messageData.data!);
        if (result.exception == null && result.data == true) {
          int i = 0;
          timer = Timer.periodic(const Duration(seconds: 20), (Timer t) {
            if (i == 20) {
              timer!.cancel();
            }
            i++;
          });
          getOverViewExplicitly(showDefault: true);
        } else {
          getOverViewExplicitly(showDefault: true);
        }
      } else {
        getOverViewExplicitly(showDefault: true);
      }
    } else {
      getOverViewExplicitly(showDefault: true);
    }
  }
}
