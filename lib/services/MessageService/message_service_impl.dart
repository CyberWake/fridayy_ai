import 'package:fridayy_one/business_login/models/message_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/services/MessageService/message_service.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:sms_advanced/sms_advanced.dart';

class MessageServiceImpl extends MessageService {
  @override
  Future<List<Map<String, dynamic>>> readMessage() async {
    final SmsQuery query = SmsQuery();
    final List<Map<String, dynamic>> messageData = [];
    final List<SmsMessage> messages = await query.getAllSms;
    final bool savedMessageExist = await localDatabaseService.messagesExist();
    for (int i = 0; i < messages.length; i++) {
      final element = messages[i];
      final Message message = Message(
        id: element.id,
        address: element.address,
        body: element.body,
        threadId: element.threadId?.toString() ?? "-1",
        date: element.date?.microsecondsSinceEpoch ?? 0,
        dateSent: element.dateSent?.microsecondsSinceEpoch ?? 0,
      );
      if (!savedMessageExist ||
          !localDatabaseService.messageAlreadySaved(message)) {
        localDatabaseService.saveMessage(message);
        messageData.add(message.toJson());
      }
    }
    return messageData;
  }

  @override
  Future<bool> postSms(List<Map<String, dynamic>> messagesToSend) async {
    final result = await apiService.postRequest(
        ApiConstants.processMessages, {"messages": messagesToSend,},);
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }
}
