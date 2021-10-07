abstract class MessageService {
  Future<List<Map<String, dynamic>>> readMessage();
  Future postSms(List<Map<String, dynamic>> messagesToSend);
}
