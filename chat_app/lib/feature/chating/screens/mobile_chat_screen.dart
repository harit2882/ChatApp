import 'package:chat_app/feature/chating/controller/chat_controller.dart';
import 'package:chat_app/feature/chating/widgets/bottom_chat_field.dart';
import 'package:chat_app/feature/chating/widgets/chat_card.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileChatScreen extends ConsumerWidget {

  final UserModel userModel;
  const MobileChatScreen({required this.userModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.watch(chatControllerProvider).socketConnect();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 4 * w,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                userModel.profilePic
              ),
              radius: 5 * w,
              // child: SvgPicture.asset("assets/person.svg",color: Colors.white,),
            ),
            SizedBox(width: 3 * w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name,
                    overflow: TextOverflow.fade,
                  ),
                  const Text(
                    "Last seen today at 12:05",
                    style: TextStyle(fontSize: 13),
                  )
                ],
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.call),
          ),
          PopupMenuButton<String>(
              onSelected: (value){
                print(value);
              },
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              itemBuilder: (BuildContext context){
                return [
                  const PopupMenuItem(value: "New Group", child: Text("New Group")),
                  const PopupMenuItem(value: "New Broadcast", child: Text("New Broadcast")),
                  const PopupMenuItem(value: "WhatsApp Web", child: Text("WhatsApp Web")),
                  const PopupMenuItem(value: "Starred Message", child: Text("Starred Message")),
                  const PopupMenuItem(value: "Settings", child: Text("Settings")),
                ];
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatCard(receiverId:userModel.uid),
          ),
          BottomChatField(userModel: userModel)
        ],
      ),
    );
  }
}
