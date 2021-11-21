import 'package:fridayy_one/business_logic/models/message_model.dart';
import 'package:fridayy_one/services/local_database/localdatabase_service.dart';
import 'package:hive/hive.dart';

class LocalDatabaseServiceImpl extends LocalDatabaseService {
  late String userAuthKey;
  late Map<String, String> bucketInfo;

  @override
  void fetchUser() {
    // TODO: implement fetchUser
  }

  @override
  Future<String> fetchAuthKey() async {
    final messagesBox = Hive.box<Message>('messages');
    messagesBox.clear();
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
    userBox.delete('key');
    final messagesBox = Hive.box<Message>('messages');
    messagesBox.clear();
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

  @override
  Future<void> saveBucket(
    Map<String, dynamic> info,
  ) async {
    for (int i = 0; i < 2; i++) {
      final bucketBox = await Hive.openBox(i == 0 ? 'before' : 'after');
      bucketBox.put(
        'key',
        i == 0
            ? info['s3_details']['below_3_months']['fields']['key']
            : info['s3_details']['after_3_months']['fields']['key'],
      );
      bucketBox.put(
        'x-amz-algorithm',
        i == 0
            ? info['s3_details']['below_3_months']['fields']['x-amz-algorithm']
            : info['s3_details']['after_3_months']['fields']['x-amz-algorithm'],
      );
      bucketBox.put(
        'x-amz-credential',
        i == 0
            ? info['s3_details']['below_3_months']['fields']['x-amz-credential']
            : info['s3_details']['after_3_months']['fields']
                ['x-amz-credential'],
      );
      bucketBox.put(
        'x-amz-date',
        i == 0
            ? info['s3_details']['below_3_months']['fields']['x-amz-date']
            : info['s3_details']['after_3_months']['fields']['x-amz-date'],
      );
      bucketBox.put(
        'policy',
        i == 0
            ? info['s3_details']['below_3_months']['fields']['policy']
            : info['s3_details']['after_3_months']['fields']['policy'],
      );
      bucketBox.put(
        'x-amz-signature',
        i == 0
            ? info['s3_details']['below_3_months']['fields']['x-amz-signature']
            : info['s3_details']['after_3_months']['fields']['x-amz-signature'],
      );
    }
  }

  @override
  Future<Map<String, String>> fetchBucket({bool isBefore = false}) async {
    final bucketBox = await Hive.openBox(isBefore ? 'before' : 'after');
    bucketInfo = {};
    bucketInfo.putIfAbsent('key', () => bucketBox.get('key').toString());
    bucketInfo.putIfAbsent(
      'x-amz-algorithm',
      () => bucketBox.get('x-amz-algorithm').toString(),
    );
    bucketInfo.putIfAbsent(
      'x-amz-credential',
      () => bucketBox.get('x-amz-credential').toString(),
    );
    bucketInfo.putIfAbsent(
      'x-amz-date',
      () => bucketBox.get('x-amz-date').toString(),
    );
    bucketInfo.putIfAbsent('policy', () => bucketBox.get('policy').toString());
    bucketInfo.putIfAbsent(
      'x-amz-signature',
      () => bucketBox.get('x-amz-signature').toString(),
    );
    return bucketInfo;
  }
}
