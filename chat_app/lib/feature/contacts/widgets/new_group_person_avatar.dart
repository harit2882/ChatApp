import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:flutter/material.dart';

class NewGroupPersonAvatar extends StatelessWidget {
  const NewGroupPersonAvatar({Key? key, required this.contact, required this.onTap}) : super(key: key);
  final ChatModel contact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.person,size: 40,),
                ),
                Positioned(
                  bottom: -4,
                  right: -4,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: backgroundColor,width: 3.5),
                      borderRadius: const BorderRadius.all(Radius.circular(50))
                    ),
                    child: const CircleAvatar(
                      radius: 10,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(contact.name,overflow: TextOverflow.fade,)
          ],
        ),
      ),
    );
  }
}
