import 'package:fridayy_one/business_login/onboarding_screen_view_model.dart';
import 'package:fridayy_one/business_login/view_models/AuthViewModels/auth_view_model.dart';
import 'package:fridayy_one/business_login/view_models/AuthViewModels/login_view_model.dart';
import 'package:fridayy_one/business_login/view_models/AuthViewModels/otp_verification_view_model.dart';
import 'package:fridayy_one/business_login/view_models/AuthViewModels/signup_view_model.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_view_model.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/offer_screen_view_model.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/spending_screen_view_model.dart';
import 'package:fridayy_one/business_login/view_models/splash_screen_view_model.dart';
import 'package:fridayy_one/services/Api/api_service_implementation.dart';
import 'package:fridayy_one/services/LocalDatabase/localdatabase_service_impl.dart';
import 'package:fridayy_one/services/Navigation/navigation_service_implementation.dart';
import 'package:fridayy_one/services/SizeConfig/size_config_implementation.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;
final navigationService = serviceLocator<NavigationServiceImpl>();
final sizeConfig = serviceLocator<SizeConfigImpl>();
final apiService = serviceLocator<ApiServiceImpl>();
final localDatabaseService = serviceLocator<LocalDatabaseServiceImpl>();

void setupServiceLocator() {
  serviceLocator.registerSingleton(SizeConfigImpl());
  serviceLocator.registerSingleton(NavigationServiceImpl());
  serviceLocator.registerSingleton(ApiServiceImpl());
  serviceLocator.registerSingleton(LocalDatabaseServiceImpl());

  serviceLocator.registerFactory(() => SplashScreenViewModel());
  serviceLocator.registerFactory(() => OnBoardingScreenViewModel());
  serviceLocator.registerFactory(() => AuthScreenViewModel());
  serviceLocator.registerFactory(() => LoginScreenViewModel());
  serviceLocator.registerFactory(() => SignupScreenViewModel());
  serviceLocator.registerFactory(() => OtpVerificationViewModel());
  serviceLocator.registerFactory(() => HomeScreenHolderViewModel());
  serviceLocator.registerFactory(() => HomeScreenViewModel());
  serviceLocator.registerFactory(() => OfferScreenViewModel());
  serviceLocator.registerFactory(() => SpendingScreenViewModel());
}
