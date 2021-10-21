import 'dart:io';

import 'package:fridayy_one/business_login/models/message_model.dart';
import 'package:fridayy_one/business_login/models/pass_call_outcome.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/services/MessageService/message_service.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sms_advanced/sms_advanced.dart';

class MessageServiceImpl extends MessageService {
  UserOverView userOverView = UserOverView(
    user: User(userName: ' '),
    offer: Offer(
      notifiedOffers: [],
      offersExpiring: 0,
      totalOffers: 0,
      activeOffers: 0,
    ),
    spending: Spending(month: '', currency: '', amount: 0, distribution: []),
    financial: Financial(percentile: 0),
  );

  Map<String, String> s3BucketFields = {
    "key": "b4ca9887-07e2-404b-bc29-cf5e141a97bc",
    "x-amz-algorithm": "AWS4-HMAC-SHA256",
    "x-amz-credential":
        "AKIAYTKJU2VWL42NSUPC/20211020/ap-south-1/s3/aws4_request",
    "x-amz-date": "20211020T202945Z",
    "policy":
        "eyJleHBpcmF0aW9uIjogIjIwMjEtMTAtMjdUMjA6Mjk6NDVaIiwgImNvbmRpdGlvbnMiOiBbeyJidWNrZXQiOiAiZnJpZGF5LXByZXNpZ25lZC11cmxzIn0sIHsia2V5IjogImI0Y2E5ODg3LTA3ZTItNDA0Yi1iYzI5LWNmNWUxNDFhOTdiYyJ9LCB7IngtYW16LWFsZ29yaXRobSI6ICJBV1M0LUhNQUMtU0hBMjU2In0sIHsieC1hbXotY3JlZGVudGlhbCI6ICJBS0lBWVRLSlUyVldMNDJOU1VQQy8yMDIxMTAyMC9hcC1zb3V0aC0xL3MzL2F3czRfcmVxdWVzdCJ9LCB7IngtYW16LWRhdGUiOiAiMjAyMTEwMjBUMjAyOTQ1WiJ9XX0=",
    "x-amz-signature":
        "8796b85df59d30d5c159bc4e52e917f7a02f63eb6c7cad457666ba64ba4f95c7"
  };
  String bucketUrl = "https://friday-presigned-urls.s3.amazonaws.com/";

  @override
  Future<CallOutcome<String>> readMessage() async {
    try {
      final SmsQuery query = SmsQuery();
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
        if (savedMessageExist) {
          localDatabaseService.saveMessage(message);
          messageData.add(message.toJson());
        } else if (!localDatabaseService.messageAlreadySaved(message)) {
          localDatabaseService.saveMessage(message);
          messageData.add(message.toJson());
        }
      }
      if (messageData.isNotEmpty) {
        final directory = await getApplicationDocumentsDirectory();
        final File messagesFile = File('${directory.path}/messages.json');
        messagesFile.writeAsStringSync(messageData.toString());
        return CallOutcome<String>(data: messagesFile.path);
      } else {
        return CallOutcome<String>(
          exception: Exception('Messages already synced'),
        );
      }
    } on Exception catch (e) {
      return CallOutcome<String>(exception: e);
    }
  }

  @override
  Future<CallOutcome<bool>> postSms(
    String messagesToSend, {
    String? url,
    Map<String, String>? fields,
  }) async {
    try {
      bucketUrl = url ?? bucketUrl;
      s3BucketFields = fields ?? s3BucketFields;
      final postUri = Uri.parse(bucketUrl);
      final request = http.MultipartRequest("POST", postUri);
      request.fields.addAll(s3BucketFields);
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          messagesToSend,
        ),
      );
      final uploadResult = await request.send();
      if (uploadResult.statusCode == 204) {
        final CallOutcome<Map<String, dynamic>> result =
            await apiService.postRequest(
          ApiConstants.processMessages,
          {'s3_token': s3BucketFields['key']},
        );
        if (result.data != null) {
          userOverView = UserOverView.fromJson(result as Map<String, dynamic>);
        } else if (result.exception != null) {
          return CallOutcome<bool>(exception: result.exception);
        }
      }
      return CallOutcome<bool>(data: request.finalized);
    } on Exception catch (e) {
      print(e);
      return CallOutcome<bool>(exception: e);
    }
  }
}
