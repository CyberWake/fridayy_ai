import 'package:fridayy_one/business_logic/models/message_model.dart';

abstract class LocalDatabaseService {
  Future<String> fetchAuthKey();
  void fetchUser();
  void saveUserAuth(String authKey);
  Future<Map<String, String>> fetchBucket({bool isBefore});
  void saveBucket(Map<String, dynamic> info);
  void logoutUser();
  void saveMessage(Message message);
  Future<bool> messagesExist();
  bool messageAlreadySaved(Message messageId);
  void saveLastRefresh();
  Future<String> fetchLastRefreshed();
}
