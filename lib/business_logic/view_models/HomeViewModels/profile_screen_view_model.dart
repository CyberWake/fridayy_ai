import 'package:fridayy_one/business_logic/models/new_models/new_user_overview_model.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/dummy_data.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class ProfileScreenViewModel extends BaseModel {
  User user = User(userName: ' ');

  init() async {
    setState(ViewState.busy);
    final result = await apiService.getRequest(ApiConstants.userProfile);
    if (result.data != null) {
      print(result.data);
      user = User.fromJson(result.data as Map<String, dynamic>);
      setState(ViewState.idle);
    } else if (result.exception != null) {
      user = User.fromJson(userProfileDummy);
      setState(ViewState.idle);
    }
  }

  logout() async {
    final CallOutcome<Map<String, dynamic>> result =
        await apiService.postRequest(ApiConstants.userLogout, {});
    if (result.exception != null) {
      navigationService.showSnackBar(result.exception.toString());
    } else if (result.data!['result'] as bool) {
      localDatabaseService.logoutUser();
      print(result.data);
      navigationService.removeAllAndPush(
        Routes.authScreen,
        Routes.splashScreen,
      );
    }
  }
}
