import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/enums.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class ProfileScreenViewModel extends BaseModel {
  User user = User(userName: ' ');
  late HomeScreenHolderViewModel homeModel;

  init(HomeScreenHolderViewModel model) async {
    homeModel = model;
    setState(ViewState.busy);
    if (homeModel.user == null) {
      final result = await apiService.getRequest(ApiConstants.userProfile);
      if (result.data != null) {
        user = User.fromJson(result.data as Map<String, dynamic>);
        homeModel.user = user;
      } else if (result.exception != null) {}
    }
    if (homeModel.currentTabIndex == 3) {
      setState(ViewState.idle);
    }
  }

  logout() async {
    final result = await apiService.getRequest(ApiConstants.userLogout);
    if (result.exception != null) {
      navigationService.showSnackBar(result.exception.toString());
    } else if (result.data != null) {
      localDatabaseService.logoutUser();
      navigationService.removeAllAndPush(
        Routes.authScreen,
        Routes.splashScreen,
      );
    }
  }
}
