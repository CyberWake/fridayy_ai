import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 0)
class Message {
  Message({
    required this.id,
    required this.address,
    required this.body,
    required this.threadId,
    required this.date,
    required this.dateSent,
  });
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? address;
  @HiveField(2)
  String? body;
  @HiveField(3)
  String? threadId;
  @HiveField(4)
  int? date;
  @HiveField(5)
  int? dateSent;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['address'] = this.address;
    data['body'] = this.body;
    data['thread_id'] = this.threadId;
    data['date'] = this.date;
    data['dateSent'] = this.dateSent;
    return data;
  }
}
