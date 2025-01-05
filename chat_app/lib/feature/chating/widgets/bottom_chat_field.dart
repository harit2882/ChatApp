// import 'dart:io';
//
// import 'package:chat_app/utils/MySize.dart';
// import 'package:chat_app/utils/colors.dart';
// import 'package:chat_app/utils/size_config.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
//
// final emojiProvider = StateProvider<bool>((ref)=>false);
// final sendButtonProvider = StateProvider<bool>((ref) => false);
//
// final messageControllerProvider = Provider<TextEditingController>((_) => TextEditingController());
//
//
//
// class BottomChatField extends ConsumerWidget {
//
//   // final TextEditingController _messageController = TextEditingController();
//
//   void sendTextMessage() async {
//     // if (isShowSendButton) {
//     //   ref.read(chatControllerProvider).sendTextMessage(
//     //       context, _messageController.text.trim(), widget.recieverUserId );
//     //
//     //   setState(() {
//     //     _messageController.text = "";
//     //   });
//     // }
//   }
//
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     print("build");
//     final isEmoji = ref.watch(emojiProvider);
//     final isShowSendButton = ref.watch(sendButtonProvider);
//
//     SizeConfig().init(context);
//     return WillPopScope(
//       onWillPop: (){
//         if (isEmoji) {
//             ref.read(emojiProvider.notifier).state = !isEmoji;
//           return Future.value(false);
//         } else {
//           return Future.value(true);
//         }
//
//       },
//       child: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     onTap: (){
//                       if (isEmoji) {
//
//                         ref.read(emojiProvider.notifier).state = !isEmoji;
//                       }
//                     },
//                     controller: ref.read(messageControllerProvider),
//                     onChanged: (val) {
//                       if (val.isNotEmpty) {
//                         ref.read(sendButtonProvider.notifier).state = true;
//                       } else {
//                         ref.read(sendButtonProvider.notifier).state = false;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: mobileChatBoxColor,
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 1.5 * w),
//                         child: SizedBox(
//                           width: 16 * w,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               InkResponse(
//                                 onTap: () {
//
//                                   FocusScope.of(context).unfocus();
//                                   ref.read(emojiProvider.notifier).state = !isEmoji;
//
//                                 },
//                                 child: const Icon(
//                                   Icons.emoji_emotions,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               InkResponse(
//                                   onTap: () {},
//                                   child: Icon(
//                                     Icons.gif,
//                                     color: Colors.grey,
//                                     size: 9 * w,
//                                   ))
//                             ],
//                           ),
//                         ),
//                       ),
//                       suffixIcon: !isShowSendButton
//                           ? Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 1.5 * w),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             InkResponse(
//                               onTap: () {},
//                               child: const Icon(
//                                 Icons.camera_alt,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 2 * w,
//                             ),
//                             InkResponse(
//                               onTap: () {},
//                               child: const Icon(
//                                 Icons.attach_file,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                           : null,
//                       hintText: 'Type a message!',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: const BorderSide(
//                           width: 0,
//                           style: BorderStyle.none,
//                         ),
//                       ),
//                       contentPadding: const EdgeInsets.all(10),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(1.5 * w),
//                   child: CircleAvatar(
//                     radius: 6 * w,
//                     backgroundColor: messageColor,
//                     child: GestureDetector(
//                       onTap: sendTextMessage,
//                       child: Icon(
//                         isShowSendButton ? Icons.send : Icons.mic,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (isEmoji) _emojiPicker(ref)
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _emojiPicker(WidgetRef ref) {
//     final messageController = ref.watch(messageControllerProvider);
//     return SizedBox(
//       height: 33 * h,
//       child: EmojiPicker(
//         onBackspacePressed: () {
//           if (messageController.text.isEmpty) {
//             ref.read(sendButtonProvider.notifier).state = false;
//           }
//         },
//         onEmojiSelected: (Category? category, Emoji? emoji) {
//           if (messageController.text.isNotEmpty){
//               ref.read(sendButtonProvider.notifier).state = true;
//           }
//         },
//         textEditingController: ref.read(messageControllerProvider),
//         // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
//         config: Config(
//           bgColor: Colors.white,
//           columns: 8,
//           emojiSizeMax: 32 *
//               (Platform.isIOS
//                   ? 1.30
//                   : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
//         ),
//       ),
//     );
//   }
// }

import 'package:chat_app/feature/chating/controller/chat_controller.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' as foundation;


class BottomChatField extends ConsumerStatefulWidget {
  const BottomChatField({required this.userModel, Key? key}) : super(key: key);
  final UserModel userModel;

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  late bool isConversation = false;

  final _messageController = Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController());

  bool isShowSendButton = false;
  bool isEmoji = false;

  // final TextEditingController _messageController = TextEditingController();

  void sendTextMessage(
      BuildContext context, WidgetRef ref, String receiverId) async {
    if (!isConversation) {
      isConversation = await ref
          .watch(chatControllerProvider)
          .isConversationHappened(widget.userModel);
    }

    if (isShowSendButton && ref.watch(_messageController).text.trim().isNotEmpty) {
      ref.read(chatControllerProvider).sendMessage(
          context, ref.watch(_messageController).text.trim(), receiverId);
      ref.watch(_messageController).clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(chatControllerProvider).isConversationHappened(widget.userModel);

    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        if (isEmoji) {
          setState(() {
            isEmoji = !isEmoji;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      if (isEmoji) setState(() => isEmoji = !isEmoji);
                    },
                    controller: ref.watch(_messageController),
                    onChanged: (val) {
                      if (val.trim().isNotEmpty) {
                        setState(() {
                          isShowSendButton = true;
                        });
                      } else {
                        setState(() {
                          isShowSendButton = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: mobileChatBoxColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.5 * w),
                        child: SizedBox(
                          width: 16 * w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkResponse(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Future.delayed(
                                          const Duration(milliseconds: 100))
                                      .whenComplete(() => setState(() {
                                            isEmoji = !isEmoji;
                                          }));
                                },
                                child: const Icon(
                                  Icons.emoji_emotions,
                                  color: Colors.grey,
                                ),
                              ),
                              InkResponse(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.gif,
                                    color: Colors.grey,
                                    size: 9 * w,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      suffixIcon: !isShowSendButton
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4 * w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: bottomSheet,
                                    child: const Icon(
                                      Icons.attach_file,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2 * w,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : null,
                      hintText: 'Type a message!',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.5 * w),
                  child: CircleAvatar(
                    radius: 6 * w,
                    backgroundColor: messageColor,
                    child: GestureDetector(
                      onTap: () =>
                          sendTextMessage(context, ref, widget.userModel.uid),
                      child: Icon(
                        isShowSendButton ? Icons.send : Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
                maintainState: true,
                maintainAnimation: true,
                visible: isEmoji,
                child: _emojiPicker())
          ],
        ),
      ),
    );
  }

  Widget _emojiPicker() {
    return SizedBox(
      height: 30 * h,
      child: EmojiPicker(
        onBackspacePressed: () {},
        onEmojiSelected: (Category? category, Emoji? emoji) {
          if (ref.watch(_messageController).text.trim().isNotEmpty) {
            setState(() {
              isShowSendButton = true;
            });
          } else {
            setState(() {
              isShowSendButton = false;
            });
          }
        },
        textEditingController: ref.watch(_messageController),
        // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
        config: Config(
          height: 256,
          checkPlatformCompatibility: true,
          viewOrderConfig: const ViewOrderConfig(),
          emojiViewConfig: EmojiViewConfig(
            emojiSizeMax: 32 *
                (foundation.defaultTargetPlatform ==
                    TargetPlatform.iOS
                    ? 1.3
                    : 1.0),
          ),
          skinToneConfig: const SkinToneConfig(),
          categoryViewConfig: const CategoryViewConfig(),
          bottomActionBarConfig: const BottomActionBarConfig(),
          searchViewConfig: const SearchViewConfig(),
        ),
      ),
      );
  }

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (context) {
          return SizedBox(
            height: 35 * h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    attachedIcon(Icons.insert_drive_file, Colors.indigo,
                        "Document", () => null),
                    attachedIcon(
                        Icons.camera_alt, Colors.pink, "Camera", () => null),
                    attachedIcon(Icons.insert_photo, Colors.purple, "Gallery",
                        () => null),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    attachedIcon(
                        Icons.headset, Colors.orange, "Audio", () => null),
                    attachedIcon(Icons.location_pin, Colors.green, "Location",
                        () => null),
                    attachedIcon(
                        Icons.person, Colors.blue, "Contact", () => null),
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget attachedIcon(
      IconData icon, Color color, String text, Function() function) {
    return Column(
      children: [
        InkWell(
          onTap: function,
          child: CircleAvatar(
            backgroundColor: color,
            radius: 10 * w,
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 1 * h,
        ),
        Text(text)
      ],
    );
  }
}
