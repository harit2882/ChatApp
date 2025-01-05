import 'package:camera/camera.dart';
import 'package:chat_app/feature/auth/screen/login_screen.dart';
import 'package:chat_app/feature/auth/screen/otp_screen.dart';
import 'package:chat_app/feature/auth/screen/user_information_screen.dart';
import 'package:chat_app/feature/camera/camera_screen.dart';
import 'package:chat_app/feature/camera/camera_view.dart';
import 'package:chat_app/feature/camera/video_view.dart';
import 'package:chat_app/feature/chating/screens/mobile_chat_screen.dart';
import 'package:chat_app/feature/chating/screens/mobile_layout_screen.dart';
import 'package:chat_app/feature/chating/screens/web_layout_screen.dart';
import 'package:chat_app/feature/contacts/screen/contacts_screen.dart';
import 'package:chat_app/feature/contacts/screen/new_group_screen.dart';
import 'package:chat_app/feature/landing/screen/landing_screen.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/responsive_layout.dart';
import 'package:chat_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static MaterialPageRoute generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.chat:
        // final arguments = settings.arguments as Map<String,dynamic>;
        // final name = arguments['name'];
        // final uid = arguments['uid'];
        final userModel = settings.arguments as UserModel;


        return MaterialPageRoute(
            builder: (BuildContext context) => MobileChatScreen(userModel: userModel));

      case RoutesName.mob_layout:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MobileLayoutScreen());

      case RoutesName.layout:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ResponsiveLayout(
                  mobileScreenLayout: MobileLayoutScreen(),
                  webScreenLayout: WebLayoutScreen(),
                ));

      case RoutesName.landing:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LandingScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      case RoutesName.otp:
        final verificationId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (BuildContext context) => OTPScreen(verificationId));

      case RoutesName.user_info:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UserInformationScreen());

      case RoutesName.contacts:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ContactsScreen());

      case RoutesName.newgroup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NewGroupScreen());

      case RoutesName.camera:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CameraScreen());

      case RoutesName.camera_view:
        final file = settings.arguments as XFile;
        return MaterialPageRoute(
            builder: (BuildContext context) => CameraViewScreen(file: file));

      case RoutesName.video_view:
        final files = settings.arguments as XFile;
        return MaterialPageRoute(
            builder: (BuildContext context) => VideoViewScreen(file: files));

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No Rout Defined"),
            ),
          );
        });
    }
  }
}
