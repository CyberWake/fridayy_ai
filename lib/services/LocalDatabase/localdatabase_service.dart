import 'package:fridayy_one/business_login/models/message_model.dart';

abstract class LocalDatabaseService {
  Future<String> fetchAuthKey();
  void fetchUser();
  void saveUserAuth(String authKey);
  void logoutUser();
  void saveMessage(Message message);
  Future<bool> messagesExist();
  bool messageAlreadySaved(Message messageId);
}
