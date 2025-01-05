import 'package:chat_app/feature/chating/model/conversation.dart';
import 'package:chat_app/models/message.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabaseHelper {

  static late Box<Message> messageBox;
  static late Box<Conversation> myUsersBox;

  static Future<void> openMessageBox() async {

    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    Hive.registerAdapter(MessageAdapter());

    messageBox = await Hive.openBox<Message>("message");

  }


  static Future<void> openMyUsersBox() async {

    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    Hive.registerAdapter(ConversationAdapter());

    myUsersBox = await Hive.openBox<Conversation>("my_users");

  }
}
