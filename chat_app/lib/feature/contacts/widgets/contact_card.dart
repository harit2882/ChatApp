
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatelessWidget {

  const ContactCard(
      {Key? key,
      required this.index,
      required this.onTap,
      required this.userModel})
      : super(key: key);
  final User userModel;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    final name = userModel.name;
    final message = userModel.phoneNumber;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ListTile(
            leading: Stack(
              children: [
                userModel.profilePic != null
                    ? CircleAvatar(
                  backgroundImage: MemoryImage(userModel.profilePic!),
                  radius: 22,
                ):CircleAvatar(
                  radius: 22,
                  child: SvgPicture.asset("assets/person.svg",color: Colors.white,),
                ),
                // if (userModel.isSelect)
                //   const Positioned(
                //     bottom: 0,
                //     right: 0,
                //     child: CircleAvatar(
                //       backgroundColor: tabColor,
                //       radius: 10,
                //       child: Icon(
                //         Icons.check,
                //         color: Colors.white,
                //         size: 18,
                //       ),
                //     ),
                //   ),
              ],
            ),
            title: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                message,
                style: const TextStyle(fontSize: 15),
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
