import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/business_logic/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';

class AuthScreenViewModel extends BaseModel {
  void gotoLogin() {
    navigationService.pushScreen(Routes.loginScreen);
  }

  void gotoSignup() {
    navigationService.pushScreen(Routes.signupScreen);
  }
}
