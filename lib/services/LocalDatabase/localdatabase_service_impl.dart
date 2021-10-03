import 'package:fridayy_one/services/LocalDatabase/localdatabase_service.dart';
import 'package:hive/hive.dart';

class LocalDatabaseServiceImpl extends LocalDatabaseService {
  late String userAuthKey;

  @override
  void fetchUser() {
    // TODO: implement fetchUser
  }

  @override
  Future<String> fetchAuthKey() async {
    final userBox = await Hive.openBox('userKey');
    userAuthKey = userBox.get('key').toString();
    return userAuthKey;
  }

  @override
  saveUserAuth(String authKey) async {
    final userBox = await Hive.openBox('userKey');
    userBox.put('key', authKey);
    userAuthKey = authKey;
  }
}
