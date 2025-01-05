import 'package:chat_app/feature/chating/controller/chat_controller.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/routes/routes_name.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/utils/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatUserProvider = StreamProvider<List<UserModel>>(
    (ref) => ref.watch(chatControllerProvider).chatUserList());

final lastMessageProvider =
    StreamProvider.family<Message?, String>((ref, receiverId) {
  return ref.watch(chatControllerProvider).getLastMessage(receiverId);
});


class ChatList extends ConsumerWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ref.watch(chatUserProvider).when(
            data: (chatUsers) {
              if (chatUsers.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: chatUsers.length,
                  itemBuilder: (context, index) {

                    final lastMessage = ref
                        .watch(chatControllerProvider)
                        .getLastMessage(chatUsers[index].uid);

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.chat,
                                arguments: chatUsers[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                chatUsers[index].name,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: ref
                                      .watch(lastMessageProvider(
                                          chatUsers[index].uid))
                                      .when(
                                          data: (lastMessage){
                                            return Text(
                                              lastMessage!=null ? lastMessage.text : "",
                                              style: const TextStyle(fontSize: 15),
                                              overflow: TextOverflow.fade,
                                            );
                                          },
                                          error: (error,stck){ },
                                          loading: () => Utils.progressBar(context))

                                  // Text(
                                  //   lastMessage != null ? lastMessage.text : "",
                                  //   style: const TextStyle(fontSize: 15),
                                  //   overflow: TextOverflow.fade,
                                  // ),
                                  ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  chatUsers[index].profilePic,
                                ),
                                radius: 30,
                                // child: SvgPicture.asset("assets/person.svg",color: Colors.white,),
                              ),
                              // trailing: Text(
                              //   lastMessage != null
                              //       ? Utils.getLastMessageTime(
                              //           context: context,
                              //           time: lastMessage.timeSent)
                              //       : "",
                              //   style: const TextStyle(
                              //     color: Colors.grey,
                              //     fontSize: 13,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        const Divider(color: dividerColor, thickness: 1),
                      ],
                    );
                  },
                );
              } else {
                return Container();
              }
            },
            error: (error, st) => ErrorPage(exception: "hello $error"),
            loading: () => Utils.progressBar(context)));
  }
}
