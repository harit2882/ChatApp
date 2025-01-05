import 'package:chat_app/feature/contacts/widgets/contact_card.dart';
import 'package:chat_app/feature/contacts/widgets/new_group_person_avatar.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({Key? key}) : super(key: key);

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  List<ChatModel> contacts = [
    ChatModel(name: "Dev Stack", status: "A full stack developer"),
    ChatModel(name: "Balram", status: "Flutter Developer..........."),
    ChatModel(name: "Saket", status: "Web developer..."),
    ChatModel(name: "Bhanu Dev", status: "App developer...."),
    ChatModel(name: "Collins", status: "Raect developer.."),
    ChatModel(name: "Kishor", status: "Full Stack Web"),
    ChatModel(name: "Testing1", status: "Example work"),
    ChatModel(name: "Testing2", status: "Sharing is caring"),
    ChatModel(name: "Divyanshu", status: "....."),
    ChatModel(name: "Helper", status: "Love you Mom Dad"),
    ChatModel(name: "Tester", status: "I find the bugs"),
  ];

  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("New Group"),
            Text(
              groups.isNotEmpty
                  ? "${groups.length} selected"
                  : "Add Participants",
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          children: [
            if (groups.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 11 * h,
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: groups.length,
                            itemBuilder: (context, index) {
                              if (groups[index].select == true) {
                                return NewGroupPersonAvatar(
                                  contact: groups[index],
                                  onTap: () {
                                    setState(() {
                                      groups.remove(contacts[index]);
                                      contacts[index].select = false;
                                    });
                                  },
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ),
                    ),
                  ),
                  const Divider(
                    color: dividerColor,
                    thickness: 1,
                    height: 0,
                  ),
                ],
              ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactCard(
                      index: index,
                      userModel: User(uid: "1", name: "fasdf", profilePic: null, phoneNumber: "fsadf"),
                      onTap: () {
                        if (contacts[index].select == false) {
                          setState(() {
                            contacts[index].select = true;
                            groups.add(contacts[index]);
                          });
                        } else {
                          setState(() {
                            contacts[index].select = false;
                            groups.remove(contacts[index]);
                          });
                        }
                      });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
