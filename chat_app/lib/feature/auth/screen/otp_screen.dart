import 'package:chat_app/feature/auth/controller/auth_controller.dart';
import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class OTPScreen extends ConsumerWidget {
  final String verificationId;

  const OTPScreen(this.verificationId, {Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifying Your Number"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(2 * h),
              child: const Text("We have sent a SMS with a OTP"),
            ),
            SizedBox(
              width: 50 * w,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: "_ _ _ _ _ _",
                    hintStyle: TextStyle(fontSize: 30)),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  
                  if(val.length == 6){
                    print("verifying OTP");
                   verifyOTP(context,val.trim(), ref);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void verifyOTP(BuildContext context, String userOTP, WidgetRef ref) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }
}
