import 'dart:io';

import 'package:chat_app/feature/auth/controller/auth_controller.dart';
import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                image == null
                    ? CircleAvatar(
                        radius: 20 * w,
                        backgroundImage: const NetworkImage(
                            "https://img.freepik.com/premium-vector/avatar-man-with-glasses-portrait-young-guy-vector-illustration-face_217290-1809.jpg?w=2000"),
                      )
                    : CircleAvatar(
                        radius: 20 * w,
                        backgroundImage: const NetworkImage(
                            "https://img.freepik.com/premium-psd/3d-avatar-character_975163-670.jpg?w=1480")),
                Positioned(
                  bottom: 0 * h,
                  right: 0 * h,
                  child: IconButton(
                    onPressed: () {
                      selectImage();
                    },
                    icon: Icon(
                      Icons.add_a_photo_rounded,
                      size: 8 * w,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: 85 * w,
                  padding: EdgeInsets.all(5 * w),
                  child: TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(hintText: "Enter Your Name "),
                  ),
                ),
                IconButton(
                    onPressed: () => storeUserData(),
                    icon: const Icon(Icons.done))
              ],
            )
          ],
        ),
      )),
    );
  }

  void selectImage() async {
    image = await Utils.pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataTOFirebase(context, name, image);
    }
  }
}
