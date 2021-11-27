import 'dart:convert';
import 'dart:io';

import 'package:fridayy_one/business_logic/models/message_model.dart';
import 'package:fridayy_one/business_logic/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/services/message/message_service.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sms_advanced/sms_advanced.dart';

class MessageServiceImpl extends MessageService {
  late Map<String, String> s3BucketFields;
  String bucketUrl = "https://friday-presigned-urls.s3.amazonaws.com/";

  @override
  Future<CallOutcome<List<Map<String, String>>>> readMessage() async {
    try {
      final SmsQuery query = SmsQuery();
      final List<Map<String, dynamic>> messageDataBelow = [];
      final List<Map<String, dynamic>> messageDataAfter = [];
      final List<Map<String, dynamic>> messageData = [];
      final List<SmsMessage> messages = await query.getAllSms;
      final bool savedMessageExist =
          !await localDatabaseService.messagesExist();
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
        if (savedMessageExist ||
            !localDatabaseService.messageAlreadySaved(message)) {
          if ((DateTime.now().subtract(const Duration(days: 90)))
                  .difference(
                    DateTime.fromMicrosecondsSinceEpoch(message.date!),
                  )
                  .inDays >
              0) {
            messageDataBelow.add(message.toJson());
          } else {
            messageDataAfter.add(message.toJson());
          }
          localDatabaseService.saveMessage(message);
          messageData.add(message.toJson());
        }
      }
      if (messageDataBelow.length > 100 && messageDataAfter.length > 100) {
        final directory = await getApplicationDocumentsDirectory();
        final File messagesFileBelow =
            File('${directory.path}/messages_below.json');
        messagesFileBelow.writeAsStringSync(jsonEncode(messageDataBelow));
        final File messagesFileAfter =
            File('${directory.path}/messages_after.json');
        messagesFileAfter.writeAsStringSync(jsonEncode(messageDataAfter));
        return CallOutcome<List<Map<String, String>>>(
          data: [
            {"messageBelow": messagesFileBelow.path},
            {"messageAfter": messagesFileAfter.path},
          ],
        );
      } else if (messageDataAfter.length > 100) {
        final directory = await getApplicationDocumentsDirectory();
        final File messagesFileAfter =
            File('${directory.path}/messages_after.json');
        messagesFileAfter.writeAsStringSync(jsonEncode(messageDataAfter));
        return CallOutcome<List<Map<String, String>>>(
          data: [
            {"messageAfter": messagesFileAfter.path},
          ],
        );
      } else if (messageDataBelow.length > 100) {
        final directory = await getApplicationDocumentsDirectory();
        final File messagesFileBelow =
            File('${directory.path}/messages_below.json');
        messagesFileBelow.writeAsStringSync(jsonEncode(messageDataBelow));
        return CallOutcome<List<Map<String, String>>>(
          data: [
            {"messageBelow": messagesFileBelow.path},
          ],
        );
      } else {
        return CallOutcome<List<Map<String, String>>>(
          exception: Exception('Messages already synced'),
        );
      }
    } on Exception catch (e) {
      return CallOutcome<List<Map<String, String>>>(exception: e);
    }
  }

  @override
  Future<CallOutcome<bool>> postSms(
    List<Map<String, String>> messageFilesPaths, {
    String? url,
    Map<String, String>? fields,
  }) async {
    try {
      for (int i = 0; i < messageFilesPaths.length; i++) {
        bucketUrl = url ?? bucketUrl;
        if (fields?.isEmpty ?? true) {
          s3BucketFields = await localDatabaseService.fetchBucket(
            isBefore: messageFilesPaths[i].keys.first == "messageBelow",
          );
        }
        s3BucketFields = fields ?? s3BucketFields;
        final postUri = Uri.parse(bucketUrl);
        final request = http.MultipartRequest("POST", postUri);
        request.fields.addAll(s3BucketFields);
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            messageFilesPaths[i].values.first,
          ),
        );
        final uploadResult = await request.send();
        if (uploadResult.statusCode != 204) {
          return CallOutcome<bool>(
            exception: Exception(uploadResult.statusCode),
          );
        }
      }
      final CallOutcome<Map<String, dynamic>> result =
          await apiService.postRequest(
        ApiConstants.messageTransit,
        {'s3_token': s3BucketFields['key']!.split('/')[2]},
      );
      if (result.data != null && result.exception == null) {
        return CallOutcome<bool>(data: true);
      } else {
        return CallOutcome<bool>(exception: result.exception);
      }
    } on Exception catch (e) {
      return CallOutcome<bool>(exception: e);
    }
  }

  @override
  Future<CallOutcome> markUnread() {
    // TODO: implement markUnread
    throw UnimplementedError();
  }
}
