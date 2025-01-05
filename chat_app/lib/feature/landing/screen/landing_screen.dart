import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/routes/routes_name.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:chat_app/utils/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';


class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Welcome to WhatsApp',
            style: TextStyle(fontSize: 8 * sbw, fontWeight: FontWeight.w600),
          ),
          Image.asset(
            'assets/bg.png',
            color: tabColor,
            width: 40 * h,
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Read our Privacy Policy. Tap \"Agree and Continue\" to accept the Terms of Services",
                  style: TextStyle(color: greyColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                  width: 75 * w,
                  child: CustomButton(
                    text: 'AGREE AND CONTINUE',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                  )
              ),
            ],
          )
        ],
      )),
    );
  }
}
