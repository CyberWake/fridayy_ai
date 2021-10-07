import 'package:fridayy_one/business_login/models/message_model.dart';
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

  @override
  logoutUser() async {
    final userBox = await Hive.openBox('userKey');
    userBox.clear();
  }

  @override
  void saveMessage(Message message) {
    final messagesBox = Hive.box<Message>('messages');
    messagesBox.put(message.id, message);
  }

  @override
  bool messageAlreadySaved(Message message) {
    final messagesBox = Hive.box<Message>("messages");
    final data = messagesBox.get(message.id);
    if (data != null) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> messagesExist() async {
    final bool exists = await Hive.boxExists('messages');
    return exists;
  }
}
