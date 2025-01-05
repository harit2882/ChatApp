import 'dart:async';
import 'package:chat_app/enum/message_enum.dart';
import 'package:chat_app/enum/message_status.dart';
import 'package:chat_app/feature/chating/HiveDatabaseHelper.dart';
import 'package:chat_app/feature/chating/model/conversation_model.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ChatRepository({required this.firestore, required this.auth});

  Future<void> addChatUserOnFirstMsg(UserModel userModel) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('my_users')
          .doc(userModel.uid)
          .set({'isConversation': true});

      await firestore
          .collection('users')
          .doc(userModel.uid)
          .collection('my_users')
          .doc(auth.currentUser!.uid)
          .set({'isConversation': true});
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isConversationHappened(UserModel userModel) async {
    final conversationJson = await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('my_users')
        .doc(userModel.uid)
        .get();

    if (conversationJson.data() != null) {
      return ConversationModel
          .fromJson(conversationJson.data()!)
          .isConversation;
    } else {
      addChatUserOnFirstMsg(userModel);
      return true;
    }
  }

  Stream<List<UserModel>> myChatUsers() {
    print("myChatUser");

    print(auth.currentUser!.uid);

    final StreamController<List<Message>> controller =
    StreamController<List<Message>>();

    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('my_users')
        .snapshots()
        .asyncMap((event) async {
      List<UserModel> chatUsers = [];

      print("myuser length ==> ${event.docs.length}");

      for (var document in event.docs) {
        var userData =
        await firestore.collection('users').doc(document.id).get();

        if (userData.exists) {
          var user = UserModel.fromJson(userData.data()!);
          chatUsers.add(user);
        } else {
          print('User data not found for document ID: ${document.id}');
        }
      }
      return chatUsers;
    });
  }

  // Stream<List<UserModel>> chatUserList() async {
  //   final users = List.from(HiveDatabaseHelper.myUsersBox.values)
  //     ..sort((a, b) => b.timeSent.compareTo(a.timeSent));
  //
  //   if (users.isNotEmpty) {
  //     for (var user in users) {
  //       print("Users ====> ${user.userId} ${users.length}");
  //     }
  //
  //     final List<UserModel> chatUser = [];
  //
  //     final userDocs = users.map((user) {
  //
  //       firestore
  //           .collection('users')
  //           .doc(user.userId)
  //           .snapshots()
  //           .map((event) => UserModel.fromJson(event.data()!))
  //           .listen((event) {
  //
  //             chatUser.add(event);
  //       });
  //
  //
  //       return chatUser;
  //     });
  //   }
  // }

  // Stream<List<UserModel>> chatUserList() {
  //
  //   final users = List.from(HiveDatabaseHelper.myUsersBox.values)
  //     ..sort((a, b) => b.timeSent.compareTo(a.timeSent));
  //
  //   for (var user in users) {
  //     print("Users ====> ${user.userId} ${users.length}");
  //   }
  //
  //   final controller = StreamController<List<UserModel>>.broadcast();
  //
  //   if (users.isNotEmpty) {
  //     final userDocs = users.map((user) {
  //       return FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(user.userId)
  //           .snapshots()
  //           .map((doc) => UserModel.fromJson(doc.data()!));
  //     }).toList();
  //
  //     // Combine the streams of all user documents into a single stream of lists
  //     final combinedStream = StreamZip(userDocs).map((users) {
  //       return users.where((user) => user != null).toList();
  //     });
  //
  //     // Update the stream controller with the latest list of users
  //     final subscription = combinedStream.listen((users) {
  //       controller.add(users);
  //     }, onError: (error) {
  //       controller.addError(error);
  //     }, onDone: () {
  //       controller.close();
  //     });
  //
  //     // Cancel the subscription when the controller is closed
  //     controller.onCancel = subscription.cancel;
  //   } else {
  //     controller.add([]);
  //     controller.close();
  //   }
  //
  //   return controller.stream;
  // }

  // Stream<List<UserModel>> myChatUsers() {
  //   return firestore
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('my_users')
  //       .snapshots()
  //       .asyncMap((event) async {
  //     List<UserModel> chatUsers = [];
  //
  //     for (var document in event.docs) {
  //       firestore
  //           .collection('users')
  //           .doc(document.id)
  //           .snapshots()
  //           .listen((userData) {
  //         if (userData.exists) {
  //           var user = UserModel.fromJson(userData.data()!);
  //           chatUsers.add(user);
  //         } else {
  //           print('User data not found for document ID: ${document.id}');
  //         }
  //       });
  //     }
  //     return chatUsers;
  //   });
  // }


  // Stream<List<UserModel>> chatUserList() {
  //   final controller = StreamController<List<UserModel>>.broadcast();
  //
  //
  //   void updateStream() {
  //     final users = List.from(HiveDatabaseHelper.myUsersBox.values)
  //       ..sort((a, b) => b.timeSent.compareTo(a.timeSent));
  //
  //     final userDocs = users.map((user) {
  //       return FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(user.userId)
  //           .snapshots()
  //           .map((doc) => UserModel.fromJson(doc.data()!));
  //     }).toList();
  //
  //     // Combine the streams of all user documents into a single stream of lists
  //     final combinedStream = StreamZip(userDocs).map((users) {
  //       return users.where((user) => user != null).toList();
  //     });
  //
  //     // Update the stream controller with the latest list of users
  //     controller.addStream(combinedStream);
  //   }
  //
  //   // Listen to changes in the Hive box and update the stream accordingly
  //   HiveDatabaseHelper.myUsersBox.watch().listen((event) {
  //     updateStream();
  //   });
  //
  //   // Call updateStream() once to initially populate the stream
  //   updateStream();
  //
  //   return controller.stream;
  // }


  Stream<List<UserModel>> chatUserList() async* {

    StreamController<List<UserModel>> controller = StreamController();


    //BehaviorSubject<List<UserModel>> controller = BehaviorSubject.seeded([]);

    final initialUserList = await  _getUpdatedUserList();

    controller.add(initialUserList);

    HiveDatabaseHelper.myUsersBox
        .watch()
        .listen((event) async {

      List<UserModel> userList = await _getUpdatedUserList();

      print("User List ----> $userList");
      controller.add(userList);

    });

    yield* controller.stream;

  }

  Future<List<UserModel>> _getUpdatedUserList() async {

    final users = List.from(HiveDatabaseHelper.myUsersBox.values)
      ..sort((a, b) => b.timeSent.compareTo(a.timeSent));

    final userDocs = await Future.wait(users.map((user) =>
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.userId)
            .get()));

    final userList = userDocs.map((doc) => UserModel.fromJson(doc.data()!))
        .toList();

    print("User List2 ----> $userList");

    return userList;
  }


  Future<void> socketConnect() async {
    socket!.connect();
    if(FirebaseAuth.instance != null) {
      socket!.emit("signin", FirebaseAuth.instance.currentUser?.uid);
    }
    socket!.onConnect((data) {
      print("Connected harit");
    });
    socket!.onConnectError((data) => print("My error : $data"));
  }

  Future<void> sendMessage(BuildContext context, String text,
      String receiverId) async {
    var columnId = const Uuid().v1();

    print("Socket ==========>  ${socket!.connected}");

    if (socket!.connected) {
      final message = Message(
          senderId: auth.currentUser!.uid,
          receiverId: receiverId,
          text: text,
          type: MessageEnum.text,
          timeSent: DateTime.now(),
          columnId: columnId,
          isSeen: false,
          msgStatus: MessageStatus.sent);

      socket!.emit("message", message);
      HiveDatabaseHelper.messageBox.add(message);
      print("true socket ===> ${message.msgStatus}  ${message.text}");
    } else {
      final message = Message(
          senderId: auth.currentUser!.uid,
          receiverId: receiverId,
          text: text,
          type: MessageEnum.text,
          timeSent: DateTime.now(),
          columnId: columnId,
          isSeen: false,
          msgStatus: MessageStatus.not);

      HiveDatabaseHelper.messageBox.add(message);

      print("false socket ===> ${message.msgStatus}  ${message.text}");
    }
  }

  // Message? getLastMessage(String receiverId) {
  //   try {
  //     return HiveDatabaseHelper.messageBox.values.lastWhere(
  //         (msg) => msg.receiverId == receiverId || msg.senderId == receiverId);
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Stream<Message?> getLastMessage(String receiverId) async* {

    //BehaviorSubject<Message?> _chatStream = BehaviorSubject.seeded(null);

    StreamController<Message?> _chatStream = StreamController();

    final messages = HiveDatabaseHelper.messageBox.values.lastWhere(
            (msg) =>
        msg.receiverId == receiverId || msg.senderId == receiverId);
    _chatStream.add(messages);

    HiveDatabaseHelper.messageBox.watch().where((event) {
      final message = event.value as Message;
      return message.receiverId == receiverId || message.senderId == receiverId;
    }).listen((event) {
      final messages = HiveDatabaseHelper.messageBox.values.lastWhere(
              (msg) =>
          msg.receiverId == receiverId || msg.senderId == receiverId);
      _chatStream.add(messages);
    });

    yield* _chatStream.stream;
  }

  Stream<List<Message>> getChatStream(String receiverId) async* {

    //BehaviorSubject<List<Message>> _chatStream = BehaviorSubject.seeded([]); Same work as StreamController()

    StreamController<List<Message>> _chatStream = StreamController();

    final messages = HiveDatabaseHelper.messageBox.values
        .where(
            (msg) => msg.receiverId == receiverId || msg.senderId == receiverId)
        .toList();
    _chatStream.add(messages);

    HiveDatabaseHelper.messageBox.watch().where((event) {
      final message = event.value as Message;
      return message.receiverId == receiverId || message.senderId == receiverId;
    }).listen((event) {
      final messages = HiveDatabaseHelper.messageBox.values
          .where((msg) =>
      msg.receiverId == receiverId || msg.senderId == receiverId)
          .toList();
      _chatStream.add(messages);
    });

    yield* _chatStream.stream;
  }

  // List<Message> getInitialMessages(String receiverId) {
  //   final messages = HiveDatabaseHelper.messageBox.values
  //       .where(
  //           (msg) => msg.receiverId == receiverId || msg.senderId == receiverId)
  //       .toList();
  //   return messages;
  // }
}
