// import 'dart:async';
// import 'dart:isolate';
// import 'dart:ui';
// import 'package:chat_app/feature/chating/DatabaseHelper.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_isolate/flutter_isolate.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class SocketService {
//   static final SocketService _singleton = SocketService._internal();
//   factory SocketService() => _singleton;
//
//   IO.Socket? socket; // Make the socket field non-nullable and initialize it later
//   FlutterIsolate? _isolate; // Make the _isolate field non-nullable and initialize it later
//
//   static DatabaseHelper helper = DatabaseHelper();
//
//   SocketService._internal() {
//     initSocket();
//   }
//
//   void initSocket() async {
//     // Create a new isolate for the socket connection
//     _isolate = await FlutterIsolate.spawn(startSocket,ReceivePort().sendPort);
//
//     // Listen for messages from the isolate to initialize the socket connection
//     final receivePort = ReceivePort();
//     IsolateNameServer.registerPortWithName(receivePort.sendPort, 'socket_receive_port');
//     receivePort.listen((message) async {
//       if (message is IO.Socket) {
//         socket = message;
//         socket!.connect();
//         socket!.emit("signin", FirebaseAuth.instance.currentUser!.uid);
//         socket!.onConnect((data) {
//           print("Connected");
//         });
//         socket!.onConnectError((data) => print("My error : $data"));
//       }
//     });
//   }
// data
//   static void startSocket(SendPort sendPort) async {
//     // Initialize the socket connection
//
//     socket.on('connect', (_) {
//       print('Socket connected in the background');
//     });
//     socket.on('message', (data) {
//       print('Received message in the background: $data');
//       helper.insertMessage(data);
//     });
//
//     // Send the initialized socket connection to the main isolate
//     sendPort.send(socket);
//   }
//
//   void dispose() {
//     // Close the socket and the receive port of the isolate
//     socket!.disconnect();
//     IsolateNameServer.removePortNameMapping('socket_receive_port');
//   }
//
//   // static Stream<IO.Socket> get receiveStream async* {
//   //   // Get a reference to the receive port of the isolate
//   //   final port = await IsolateNameServer.lookupPortByName('socket_receive_port');
//   //   yield* port?.cast<IO.Socket>();
//   // }
// }
//
//
//
//
// // import 'dart:async';
// // import 'dart:isolate';
// // import 'package:socket_io_client/socket_io_client.dart' as IO;
// //
// // class SocketService {
// //   static final SocketService _singleton = SocketService._internal();
// //   factory SocketService() => _singleton;
// //
// //   late IO.Socket socket; // Make the socket field non-nullable and initialize it later
// //   late Isolate _isolate; // Make the _isolate field non-nullable and initialize it later
// //
// //   SocketService._internal() {
// //     initSocket();
// //   }
// //
// //   void initSocket() async {
// //     // Create a new isolate for the socket connection
// //     _isolate = await Isolate.spawn(startSocket, ReceivePort().sendPort);
// //
// //     // Listen for messages from the isolate to initialize the socket connection
// //     ReceivePort receivePort = ReceivePort();
// //     _isolate.addOnExitListener(receivePort.sendPort);
// //     receivePort.listen((message) {
// //       if (message is IO.Socket) {
// //         socket = message;
// //         socket.connect();
// //       }
// //     });
// //   }
// //
// //   static void startSocket(SendPort sendPort) async {
// //     // Initialize the socket connection
// //     IO.Socket socket = IO.io('http://localhost:3000');
// //     socket.on('connect', (_) {
// //       print('Socket connected in the background');
// //     });
// //     socket.on('message', (data) {
// //       print('Received message in the background: $data');
// //     });
// //
// //     // Send the initialized socket connection to the main isolate
// //     sendPort.send(socket);
// //   }
// // }
