class ChatModel {
  final String name;
  final String status;
  bool select = false;

  ChatModel({required this.name, required this.status, this.select = false});
}

// class ChatModel {
//   late String name;
//   late String icon;
//   late bool isGroup;
//   late String time;
//   late String currentMessage;
//   late String status;
//   late bool select = false;
//   late int id;
//
//   ChatModel(
//       this.name,
//       this.icon,
//       this.isGroup,
//       this.time,
//       this.currentMessage,
//       this.status,
//       this.select);
// }
