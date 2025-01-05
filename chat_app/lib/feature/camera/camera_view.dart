import 'dart:io';

import 'package:camera/camera.dart';
import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CameraViewScreen extends StatelessWidget {
  const CameraViewScreen({Key? key, required this.file}) : super(key: key);
  final XFile file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => null,
              icon: const Icon(
                Icons.crop_rotate,
                size: 25,
              )),
          IconButton(
              onPressed: () => null,
              icon: const Icon(
                Icons.emoji_emotions_outlined,
                size: 25,
              )),
          IconButton(
              onPressed: () => null,
              icon: const Icon(
                Icons.title,
                size: 25,
              )),
          IconButton(
              onPressed: () => null,
              icon: const Icon(
                Icons.edit,
                size: 25,
              ))
        ],
      ),
      body: SizedBox(
        height: sh,
        width: sw,
        child: Stack(
          children: [
            SizedBox(
              height: 75*h,
              width: sw,
              child: Image.file(
                File(file.path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 2*h,
              child: Container(
                width: sw,
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                child: TextFormField(
                  maxLines: 6,
                  minLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Caption...",
                    prefixIcon: const Icon(Icons.add_photo_alternate,color: Colors.white ,),

                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17
                    ),
                    suffixIcon: CircleAvatar(
                      radius: 6 * w,
                      backgroundColor: messageColor,
                      child: const Icon(
                         Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}

// class CameraViewScreen extends StatelessWidget {
//   const CameraViewScreen({Key? key, required this.file}) : super(key: key);
//   final XFile file;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Image.file(
//                 File(file.path),
//                 fit: BoxFit.cover,
//               ),
//               SafeArea(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                         onPressed: () => null,
//                         icon: const Icon(
//                           Icons.crop_rotate,
//                           size: 25,
//                         )),
//                     IconButton(
//                         onPressed: () => null,
//                         icon: const Icon(
//                           Icons.emoji_emotions_outlined,
//                           size: 25,
//                         )),
//                     IconButton(
//                         onPressed: () => null,
//                         icon: const Icon(
//                           Icons.title,
//                           size: 25,
//                         )),
//                     IconButton(
//                         onPressed: () => null,
//                         icon: const Icon(
//                           Icons.edit,
//                           size: 25,
//                         ))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           TextField(
//             style: const TextStyle(color: Colors.white, fontSize: 17),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: "Add Caption...",
//               prefixIcon: const Icon(
//                 Icons.add_photo_alternate,
//                 color: Colors.white,
//               ),
//               hintStyle: const TextStyle(color: Colors.white, fontSize: 17),
//               suffixIcon: CircleAvatar(
//                 radius: 6 * w,
//                 backgroundColor: messageColor,
//                 child: const Icon(
//                   Icons.check,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
