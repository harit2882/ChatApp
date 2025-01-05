
class ChatContact {
  final String name;
  final String profilePic;
  final String contactId;
  final String lastMessage;
  final DateTime timeSent;

  ChatContact(
      {required this.name,
      required this.profilePic,
      required this.contactId,
      required this.lastMessage,
      required this.timeSent});

  factory ChatContact.fromJson(Map<String, dynamic> json) {
    return ChatContact(
      name: json["name"] ?? "",
      profilePic: json["profilePic"] ?? "",
      contactId: json["contactId"] ?? "",
      lastMessage: json["lastMessage"] ?? "",
      timeSent: DateTime.fromMillisecondsSinceEpoch(json["timeSent"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profilePic": profilePic,
      "contactId": contactId,
      "lastMessage": lastMessage,
      "timeSent": timeSent.millisecondsSinceEpoch,
    };
  }
//


  // factory ChatContact.fromJson(Map<String, dynamic> json) =>
  //     ChatContact(
  //         name:json['name'],
  //         profilePic:json['profilePic'],
  //         contactId:json['contactId'],
  //         lastMessage:json['lastMessage'],
  //         timeSent:json['timeSent']);
  //
  // Map<String, dynamic> toJson() => {
  //   'name': name,
  //   'profilePic': profilePic,
  //   'contactId': contactId,
  //   'lastMessage': lastMessage,
  //   'timeSent': timeSent
  // };



}
