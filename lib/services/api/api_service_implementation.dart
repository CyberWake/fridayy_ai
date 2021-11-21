import 'dart:convert';

import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/services/Api/api_service.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:http/http.dart' as http;

class ApiServiceImpl extends ApiService {
  final Map<String, String> headerPreAuth = {
    'Content-Type': 'application/json',
    'x-internal-key': ApiConstants.authKey,
    'x-product-key': 'auth',
  };

  @override
  Future<CallOutcome<Map<String, dynamic>>> postRequest(
    String apiName,
    Map<String, dynamic> postData, {
    bool isAuth = false,
  }) async {
    try {
      print('auth Token ${localDatabaseService.userAuthKey}');
      final result = await http.post(
        Uri.parse(ApiConstants.baseUrl + apiName),
        body: jsonEncode(postData),
        headers: isAuth
            ? headerPreAuth
            : {
                'Content-Type': 'application/json',
                'x-friday-key': localDatabaseService.userAuthKey,
              },
      );
      if (result.statusCode == 200) {
        return CallOutcome<Map<String, dynamic>>(
          data: jsonDecode(result.body) as Map<String, dynamic>,
        );
      } else {
        print(result.body);
        final String errorMessage =
            jsonDecode(result.body)['detail'].toString();
        if (errorMessage.compareTo('Unauthorized') == 0) {
          localDatabaseService.logoutUser();
          navigationService.removeAllAndPush(
            Routes.authScreen,
            Routes.splashScreen,
          );
        }
        navigationService.showSnackBar(errorMessage);
        return CallOutcome<Map<String, dynamic>>(
          exception: Exception(errorMessage),
        );
      }
    } on Exception catch (e) {
      navigationService.showSnackBar('Something went wrong');
      return CallOutcome<Map<String, dynamic>>(exception: e);
    }
  }

  @override
  Future<CallOutcome<dynamic>> getRequest(String apiName) async {
    try {
      final Map<String, String> headerAuth = {
        'Content-Type': 'application/json',
        'x-friday-key':
            '3eb5488c-7cd0-43c9-9fb7-8b5434e5dba9' //localDatabaseService.userAuthKey,
      };
      final result = await http.get(
        Uri.parse(ApiConstants.baseUrl + apiName),
        headers: headerAuth,
      );
      if (result.statusCode == 200) {
        return CallOutcome<dynamic>(
          data: jsonDecode(result.body),
        );
      } else {
        final String errorMessage =
            jsonDecode(result.body)['detail'].toString();
        if (errorMessage.compareTo('Unauthorized') == 0) {
          localDatabaseService.logoutUser();
          navigationService.removeAllAndPush(
            Routes.authScreen,
            Routes.splashScreen,
          );
        }
        navigationService.showSnackBar(errorMessage);
        return CallOutcome<Map<String, dynamic>>(
          exception: Exception(errorMessage),
        );
      }
    } on Exception catch (e) {
      navigationService.showSnackBar('Something went wrong');
      return CallOutcome<Map<String, dynamic>>(exception: e);
    }
  }
}
