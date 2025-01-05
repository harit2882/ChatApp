// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:whatsapp_ui/feature/auth/controller/auth_controller.dart';
// import 'package:whatsapp_ui/feature/chating/repository/chat_repository.dart';
// import 'package:whatsapp_ui/models/chat_contact.dart';
// import 'package:whatsapp_ui/models/message.dart';
//
// final chatControllerProvider = Provider((ref) {
//   final chatRepository = ref.watch(chatRepositoryProvider);
//   return ChatController(chatRepository: chatRepository,ref: ref);
// } );
//
// class ChatController {
//
//   final ChatRepository chatRepository;
//   final ProviderRef ref;
//
//   ChatController({required this.chatRepository, required this.ref});
//
//   void sendTextMessage(BuildContext context, String text,
//       String recieverUserId) {
//     ref.read(userDataAuthProvider)
//         .whenData((value) =>
//         chatRepository.sendTextMessage(context: context,
//             text: text,
//             recieverUserId: recieverUserId,
//             senderUser: value!));
//   }
//
//   Stream<List<ChatContact>> chatContacts(){
//     print("chatcontact from controller method");
//     return chatRepository.getChatContact();
//   }
//
//   Stream<List<Message>> chatStream(String recieverUserId){
//     return chatRepository.getChatStream(recieverUserId);
//   }
//
// }

import 'dart:async';
import 'package:chat_app/feature/chating/repository/chat_repository.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository);
});

class ChatController {
  final ChatRepository chatRepository;

  ChatController({required this.chatRepository});

  void sendMessage(BuildContext context,String text, String receiverId) {

    chatRepository.sendMessage(context,text,receiverId);

  }

  Future<bool> isConversationHappened(UserModel userModel) async {
    return chatRepository.isConversationHappened(userModel);
  }

  Stream<List<UserModel>> myChatUsers(){
    return chatRepository.myChatUsers();
  }

  Stream<List<Message>> getChatStream(String receiverId){
    return chatRepository.getChatStream(receiverId);
  }

  void socketConnect(){
    chatRepository.socketConnect();
  }



  // List<Message> getInitialMessages(String receiverId){
  //   return chatRepository.getInitialMessages(receiverId);
  // }

  Stream<Message?> getLastMessage(String receiverId){
    return chatRepository.getLastMessage(receiverId);
  }


  Stream<List<UserModel>> chatUserList(){
    return chatRepository.chatUserList();
  }

}
