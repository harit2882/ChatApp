class ConversationModel {

  final bool isConversation;

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      isConversation:
          json["isConversation"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isConversation": isConversation,
    };
  }

  ConversationModel({required this.isConversation});

}