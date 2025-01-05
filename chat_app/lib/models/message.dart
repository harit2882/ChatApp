
import 'package:chat_app/enum/message_enum.dart';
import 'package:chat_app/enum/message_status.dart';
import 'package:hive_flutter/adapters.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  final String senderId;
  @HiveField(1)
  final String receiverId;
  @HiveField(2)
  final String text;
  @HiveField(3)
  final MessageEnum type;
  @HiveField(4)
  final DateTime timeSent;
  @HiveField(5)
  final String columnId;
  @HiveField(6)
  final bool isSeen;
  @HiveField(7)
  MessageStatus msgStatus;


  Message(
      {required this.senderId,
      required this.receiverId,
      required this.text,
      required this.type,
      required this.timeSent,
      required this.columnId,
      required this.isSeen,
      required this.msgStatus});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json["senderId"] ?? '',
      receiverId: json["receiverId"] ?? '',
      text: json["text"] ?? '',
      type: (json["type"] as String).toEnum(),
      timeSent: DateTime.parse(json['timeSent']),
      columnId: json["columnId"] ?? '',
      isSeen: json["isSeen"] == 'false' ? false : true,
      msgStatus: (json["msgStatus"] as String).toEnumStatus()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "text": text,
      "type": type.type.toString(),
      "timeSent": timeSent.toString(),
      "columnId": columnId,
      "isSeen": isSeen,
      "msgStatus":msgStatus.type.toString()
    };
  }


}
