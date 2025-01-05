import 'dart:async';

import 'package:camera/camera.dart';
import 'package:chat_app/enum/message_status.dart';
import 'package:chat_app/feature/auth/controller/auth_controller.dart';
import 'package:chat_app/feature/chating/HiveDatabaseHelper.dart';
import 'package:chat_app/feature/chating/model/conversation.dart';
import 'package:chat_app/feature/chating/screens/mobile_layout_screen.dart';
import 'package:chat_app/feature/landing/screen/landing_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/routes/routes.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/utils/widgets/error_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Declare a global variable to hold available cameras
late final List<CameraDescription> cameras;

// Declare a global socket connection
IO.Socket? socket;

Future<void> main() async {
  // Ensure the Flutter bindings are initialized before calling runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Open Hive database boxes for storing messages and users
  await HiveDatabaseHelper.openMessageBox();
  await HiveDatabaseHelper.openMyUsersBox();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Fetch available cameras for the app (used for video messaging or camera-related features)
  cameras = await availableCameras();

  // Establish socket connection to the server
  socket = await IO.io('http://10.0.0.140:5000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false, // We want to manually control the connection
  });

  // Connect to the server via socket
  socket!.connect();

  // Socket connection event handler
  socket!.onConnect((data) {
    // Emit a "signin" event to the server with the user's ID once connected
    socket!.emit("signin", FirebaseAuth.instance.currentUser?.uid);
    print("Connected to server");

    // Loop through messages in the local Hive database with "not sent" status
    HiveDatabaseHelper.messageBox.values.where((msg) {
      return msg.msgStatus == MessageStatus.not;
    }).forEach((message) async {
      print("Pending message: ${message.msgStatus}  ${message.text}");
      if (socket!.connected) {
        // Update message status to 'sent'
        message.msgStatus = MessageStatus.sent;

        // Save the updated message in the Hive database
        await HiveDatabaseHelper.messageBox.put(message.key, message);

        // Emit the message to the server
        socket!.emit("message", message);
        print("Offline Message sent: ${message.text}");
      }
    });
  });

  // Listen for "ping" events from the server
  socket!.on('ping', (data) {
    print('Received ping from server');
  });

  // Error handler for connection errors
  socket!.onConnectError((data) => print("Socket Connection error: $data"));

  // Handle incoming messages from the server
  socket!.on("message", (data) async {
    final message = Message.fromJson(data);

    // Store the incoming message in the Hive database
    await HiveDatabaseHelper.messageBox.add(message);

    // Create a new conversation object based on the message sender
    Conversation conversation = Conversation(
      userId: message.senderId,
      isConversation: true,
      timeSent: message.timeSent,
    );

    Conversation? user;

    try {
      // Attempt to find the user from the local database
      user = HiveDatabaseHelper.myUsersBox.values.singleWhere(
            (user) => user.userId == message.senderId,
      );

      // If the user is found, update the conversation
      print("User found: $user");
      HiveDatabaseHelper.myUsersBox.put(user.userId, conversation);
    } catch (e) {
      // If the user is not found, add a new conversation entry
      HiveDatabaseHelper.myUsersBox.put(conversation.userId, conversation);
    }
  });

  // Run the app with Riverpod provider scope
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'OpenSans',
        ),
        primaryTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'OpenSans',
        ),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(color: appBarColor),
      ),
      home: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return ref.watch(userDataAuthProvider).when(
            data: (user) {
              // Based on authentication status, show either LandingScreen or MobileLayoutScreen
              if (user == null) {
                return const LandingScreen();
              } else {
                return const MobileLayoutScreen();
              }
            },
            error: (e, st) {
              // Show error page if an error occurs during authentication
              return ErrorPage(exception: e);
            },
            loading: () => Utils.progressBar(context), // Show loading indicator during authentication
          );
        },
      ),
      onGenerateRoute: Routes.generateRoutes, // Handle dynamic route generation
    );
  }
}