

import 'package:hive_flutter/hive_flutter.dart';
part 'conversation.g.dart';

@HiveType(typeId: 1)
class Conversation {

  @HiveField(0)
  final String userId;
  @HiveField(1)
  final bool isConversation;
  @HiveField(2)
  final DateTime timeSent;

  factory Conversation.fromJson(Map<String, dynamic> json) {

    return Conversation(
      userId : json["userId"],
      isConversation: json["isConversation"],
      timeSent: DateTime.parse(json['timeSent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "isConversation": isConversation,
      "timeSent": timeSent.toString(),
    };
  }

  Conversation({required this.userId, required this.isConversation,required this.timeSent});

}