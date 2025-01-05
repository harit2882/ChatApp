import 'package:chat_app/feature/contacts/controller/contact_controller.dart';
import 'package:chat_app/feature/contacts/widgets/contact_card.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/routes/routes_name.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/utils/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numbersOfContact = ref.watch(getMobileContactsProvider).value?.length;

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Contact"),
            Text(
              numbersOfContact != null
                  ? "$numbersOfContact Contacts"
                  : "No Contacts",
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton<String>(
              color: appBarColor,
              onSelected: (value) {
                print(value);
              },
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                      value: "Invite a Friend", child: Text("Invite a Friend")),
                  const PopupMenuItem(
                      value: "Contacts", child: Text("Contacts")),
                  const PopupMenuItem(value: "Refresh", child: Text("Refresh")),
                  const PopupMenuItem(value: "Help", child: Text("Help")),
                ];
              })
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: ref.watch(getMobileContactsProvider).when(
              data: (contactsList) {
                if (contactsList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactsList.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ButtonCard(
                            name: "New Group",
                            icon: Icons.group,
                            onTap: () => Navigator.pushNamed(
                                context, RoutesName.newgroup));
                      } else if (index == 1) {
                        return ButtonCard(
                            name: "New Contact",
                            icon: Icons.person_add,
                            onTap: () {});
                      } else {
                        return ContactCard(
                          index: index - 2,
                          onTap: () async {
                            final asyncContacts = ref
                                .watch(getChatAppContactsProvider(contactsList[index - 2].phones));
                            asyncContacts.when(
                              data: (contactUsers) {
                                if (contactUsers.isNotEmpty) {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.chat,
                                    arguments: contactUsers.first,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('This contact is not registered with the app.'),
                                    ),
                                  );
                                }
                              },
                              error: (error, stack) {
                                // Show an error message if something goes wrong.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('An error occurred: $error'),
                                  ),
                                );
                              },
                              loading: () {
                                // Optionally show a loading indicator.
                                showDialog(
                                  context: context,
                                  builder: (context) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            );


                          },
                          userModel: User(
                              uid: contactsList[index - 2].id,
                              name: contactsList[index -2].displayName,
                              profilePic: contactsList[index -2].photo,
                            phoneNumber: contactsList[index - 2].phones.isNotEmpty
                                ? contactsList[index - 2].phones.first.number
                                : 'No phone number',),
                        );
                      }
                    },
                  );
                } else {
                  return Container();
                }
              },
              error: (err, stack) => ErrorPage(exception: err),
              loading: () => Utils.progressBar(context))),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );

    // void selectContact(WidgetRef ref, Contact selectedContact,BuildContext context){
    //
    //   ref.read(contactControllerProvider).selectedContact(selectedContact, context);
    //
    // }
  }
}

class ButtonCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const ButtonCard(
      {super.key, required this.name, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ListTile(
              title: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              leading: CircleAvatar(
                  backgroundColor: tabColor,
                  radius: 22,
                  child: Icon(icon, color: Colors.white)
                  // child: SvgPicture.asset("assets/person.svg",color: Colors.white,),
                  ),
            ),
          ),
        ),
        const Divider(
          color: dividerColor,
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}
