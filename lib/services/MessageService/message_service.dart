import 'package:fridayy_one/business_login/models/pass_call_outcome.dart';

abstract class MessageService {
  Future<CallOutcome> readMessage();
  Future postSms(
    String messagesToSend, {
    String? url,
    Map<String, String>? fields,
  });
}
