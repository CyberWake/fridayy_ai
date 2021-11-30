import 'package:fridayy_one/business_logic/onboarding_screen_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/AuthViewModels/auth_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/AuthViewModels/login_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/AuthViewModels/otp_verification_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/AuthViewModels/signup_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/dashboard/home_screen_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/offers/brand_offers_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/offers/offer_screen_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/profile/profile_screen_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/spends/brand_transactions_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/spends/category_transactions_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/spends/spend_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/home_view_models/spends/spending_screen_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/splash_screen_view_model.dart';
import 'package:fridayy_one/services/Api/api_service_implementation.dart';
import 'package:fridayy_one/services/local_database/localdatabase_service_impl.dart';
import 'package:fridayy_one/services/message/message_service_impl.dart';
import 'package:fridayy_one/services/navigation/navigation_service_impl.dart';
import 'package:fridayy_one/services/size_config/size_config_service_impl.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;
final navigationService = serviceLocator<NavigationServiceImpl>();
final sizeConfig = serviceLocator<SizeConfigImpl>();
final apiService = serviceLocator<ApiServiceImpl>();
final localDatabaseService = serviceLocator<LocalDatabaseServiceImpl>();
final messageService = serviceLocator<MessageServiceImpl>();

void setupServiceLocator() {
  serviceLocator.registerSingleton(SizeConfigImpl());
  serviceLocator.registerSingleton(NavigationServiceImpl());
  serviceLocator.registerSingleton(ApiServiceImpl());
  serviceLocator.registerSingleton(LocalDatabaseServiceImpl());
  serviceLocator.registerSingleton(MessageServiceImpl());

  serviceLocator.registerFactory(() => SplashScreenViewModel());
  serviceLocator.registerFactory(() => OnBoardingScreenViewModel());
  serviceLocator.registerFactory(() => AuthScreenViewModel());
  serviceLocator.registerFactory(() => LoginScreenViewModel());
  serviceLocator.registerFactory(() => SignupScreenViewModel());
  serviceLocator.registerFactory(() => OtpVerificationViewModel());
  serviceLocator.registerFactory(() => HomeScreenHolderViewModel());
  serviceLocator.registerFactory(() => HomeScreenViewModel());
  serviceLocator.registerFactory(() => OfferScreenViewModel());
  serviceLocator.registerFactory(() => BrandOffersViewModel());
  serviceLocator.registerFactory(() => SpendingScreenViewModel());
  serviceLocator.registerFactory(() => BrandTransactionsViewModel());
  serviceLocator.registerFactory(() => CategoryTransactionsViewModel());
  serviceLocator.registerFactory(() => SpendViewModel());
  serviceLocator.registerFactory(() => ProfileScreenViewModel());
}
