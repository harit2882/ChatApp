import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);


    return ElevatedButton(
        onPressed: onPressed,
        child: Text(text,
          style: const TextStyle(color: blackColor),
         ),
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        minimumSize: Size(double.infinity,6 * h)
      ),
    );
  }
}
