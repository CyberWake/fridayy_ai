import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';

abstract class MessageService {
  Future<CallOutcome> readMessage();
  Future postSms(
    Map<String, List<Map<String, dynamic>>> messagesToSend, {
    String? url,
    Map<String, String>? fields,
  });
  Future<CallOutcome> markUnread();
}
