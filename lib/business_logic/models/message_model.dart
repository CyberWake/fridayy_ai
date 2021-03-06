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
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int?,
      address: map['address'] as String?,
      body: map['body'] as String?,
      threadId: map['thread_id'] as String?,
      date: map['date'] as int?,
      dateSent: map['date_sent'] as int?,
    );
  }
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
    data['date_sent'] = this.dateSent;
    return data;
  }
}
