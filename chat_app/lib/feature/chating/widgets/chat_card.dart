import 'package:chat_app/feature/chating/controller/chat_controller.dart';
import 'package:chat_app/feature/chating/widgets/my_message_card.dart';
import 'package:chat_app/feature/chating/widgets/sender_message_card.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/utils/widgets/error_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


final chatStreamProvider = StreamProvider.family<List<Message>,String>((ref,receiverId) {

  final controller = ref.watch(chatControllerProvider);
  return controller.getChatStream(receiverId);



  // socket!.on('message', (data) {
  //   final message = Message.fromJson(data);
  //   messages = [...messages,message];
  //   controller.add(messages);
  // });
  //
  // return controller.stream;

});

class ChatCard extends ConsumerWidget {
  const ChatCard({super.key, required this.receiverId});
  final String receiverId;

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return SingleChildScrollView(
        reverse: true,
        child:   Center(
          child: Consumer(
            builder: (builder, ref, child) {
              return ref.watch(chatStreamProvider(receiverId)).when(
                  data: (snapshot) {
                    final messages = snapshot;

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {

                        if (messages[index].senderId ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          return MyMessageCard(
                            message: messages[index].text,
                            date: DateFormat('hh:mm a')
                                .format(messages[index].timeSent),
                          );
                        }

                        return SenderMessageCard(
                          message: messages[index].text,
                          date: DateFormat('hh:mm a')
                              .format(messages[index].timeSent),
                        );

                      },
                    );
                  },
                  error: (error, st) => ErrorPage(exception: error),
                  loading: () => Utils.progressBar(context));
            },
          ),
        )


    );
  }
}

// class ChatCard extends StatelessWidget {
//   const ChatCard({Key? key, required this.receiverId}) : super(key: key);
//   final String receiverId;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       reverse: true,
//       child: Consumer(builder: (context, ref, child) {
//         return StreamBuilder<List<Message>>(
//           stream: ref.watch(chatStreamProvider(receiverId).stream),
//           builder: (context, snapshot) {
//
//             final messages = snapshot.data!;
//
//             return ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 if (messages[index].senderId ==
//                     FirebaseAuth.instance.currentUser!.uid) {
//                   return MyMessageCard(
//                     message: messages[index].text,
//                     date: DateFormat('hh:mm a')
//                         .format(messages[index].timeSent),
//                   );
//                 }
//                 return SenderMessageCard(
//                   message: messages[index].text,
//                   date: DateFormat('hh:mm a')
//                       .format(messages[index].timeSent),
//                 );
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }
