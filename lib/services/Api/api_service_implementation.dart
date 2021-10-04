import 'dart:convert';

import 'package:fridayy_one/business_login/utils/api_constants.dart';
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
  Future postRequest(
    String apiName,
    Map<String, dynamic> postData, {
    bool isAuth = false,
  }) async {
    try {
      print('Auth Token ${localDatabaseService.userAuthKey}');
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
        return jsonDecode(result.body);
      } else {
        print(jsonDecode(result.body));
        navigationService
            .showSnackBar(jsonDecode(result.body)['detail'].toString());
        return null;
      }
    } on Exception catch (e) {
      print(e);
      navigationService.showSnackBar(e.toString());
      return null;
    }
  }

  @override
  Future getRequest(String apiName) async {
    try {
      final Map<String, String> headerAuth = {
        'Content-Type': 'application/json',
        'x-friday-key': localDatabaseService.userAuthKey,
      };
      final result = await http.get(
        Uri.parse(ApiConstants.baseUrl + apiName),
        headers: headerAuth,
      );
      if (result.statusCode == 200) {
        return jsonDecode(result.body);
      } else {
        print(jsonDecode(result.body));
        navigationService
            .showSnackBar(jsonDecode(result.body)['detail'].toString());
        return null;
      }
    } on Exception catch (e) {
      navigationService.showSnackBar(e.toString());
      return null;
    }
  }
}
