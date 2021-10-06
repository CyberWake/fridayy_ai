import 'package:fridayy_one/business_login/models/message_model.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/api_constants.dart';
import 'package:fridayy_one/business_login/utils/enums.dart';
import 'package:fridayy_one/business_login/view_models/base_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:sms_advanced/sms_advanced.dart';

class HomeScreenViewModel extends BaseModel {
  final List<Distribution> datanew = [
    Distribution(categoryId: "FAD", percentage: 3.1),
    Distribution(categoryId: "MDCL", percentage: 4.9),
    Distribution(categoryId: "UTL", percentage: 42.9),
    Distribution(categoryId: "TRVL", percentage: 18.4),
    Distribution(categoryId: "LUX", percentage: 0.0),
    Distribution(categoryId: "FIN", percentage: 30.7),
    Distribution(categoryId: "OTH", percentage: 0.9),
    Distribution(categoryId: "EAD", percentage: 0.0),
  ];

  final double totalOffers = 2000;
  final double activeOffers = 1745;
  final double expiredOffers = 255;

  Future init() async {
    setState(ViewState.busy);
    await postSms();
    setState(ViewState.idle);
  }

  Future postSms() async {
    final messageData = [];
    final SmsQuery query = SmsQuery();
    final List<SmsMessage> messages = await query.getAllSms;
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
      if (!localDatabaseService.messageAlreadySaved(message)) {
        localDatabaseService.saveMessage(message);
        messageData.add(message.toJson());
      }
    }
    if (messageData.isNotEmpty) {
      final result = await apiService
          .postRequest(ApiConstants.processMessages, {"messages": messageData});
      if (result != null) {
        print(result);
      }
    }
  }
}
