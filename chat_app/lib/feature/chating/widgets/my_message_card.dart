import 'package:chat_app/utils/colors.dart';
import 'package:flutter/material.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;

  const MyMessageCard({Key? key, required this.message, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Card(
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.zero,
                bottomLeft: Radius.circular(15))),
        color: messageColor,
        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.done_all,
                    size: 20,
                    color: Colors.white60,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    //   Align(
    //   alignment: Alignment.centerRight,
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(
    //       maxWidth: MediaQuery.of(context).size.width - 45,
    //     ),
    //     child: Card(
    //       elevation: 1,
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    //       color: messageColor,
    //       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    //       child: Stack(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(
    //               left: 10,
    //               right: 30,
    //               top: 5,
    //               bottom: 20,
    //             ),
    //             child: Text(
    //               message,
    //               style: const TextStyle(
    //                 fontSize: 16,
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             bottom: 4,
    //             right: 10,
    //             child: Row(
    //               children: [
    //                 Text(
    //                   date,
    //                   style:const TextStyle(
    //                     fontSize: 13,
    //                     color: Colors.white60,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   width: 5,
    //                 ),
    //                 const Icon(
    //                   Icons.done_all,
    //                   size: 20,
    //                   color: Colors.white60,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
