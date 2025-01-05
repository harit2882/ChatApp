import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/utils/MySize.dart';
import 'package:chat_app/utils/routes/routes_name.dart';
import 'package:chat_app/utils/size_config.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();

    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: !controller.value.isInitialized
          ? Utils.progressBar(context)
          : Column(
              children: [
                SizedBox(
                  height: 87 * h,
                  child: CameraPreview(
                    controller,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkResponse(
                          onTap: () {
                            setState(() {
                              flash = !flash;
                              flash
                                  ? controller.setFlashMode(FlashMode.torch)
                                  : controller.setFlashMode(FlashMode.off);
                            });
                          },
                          child: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            size: 25,
                            color: Colors.white,
                          )),
                      GestureDetector(
                          onLongPress: () async {
                            controller.startVideoRecording();
                            setState(() {
                              isRecording = true;
                            });
                          },
                          onLongPressUp: () async {
                            final file = await controller.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            Navigator.pushNamed(context, RoutesName.video_view,
                                arguments: file);
                          },
                          onTap: () {
                            if (!isRecording) takePhoto(context);
                          },
                          child: isRecording
                              ? const Icon(
                                  Icons.radio_button_on,
                                  color: Colors.red,
                                  size: 80,
                                )
                              : const Icon(
                                  Icons.panorama_fish_eye,
                                  size: 70,
                                  color: Colors.white,
                                )),
                      InkResponse(
                          onTap: () {
                            setState(() {
                              isCameraFront = !isCameraFront;
                              transform = transform + pi;
                            });

                            int cameraPos = isCameraFront ? 0 : 1;

                            controller = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            controller.initialize().then((_) {
                              if (!mounted) {
                                return;
                              }
                              setState(() {});
                            }).catchError((Object e) {
                              if (e is CameraException) {
                                switch (e.code) {
                                  case 'CameraAccessDenied':
                                    // Handle access errors here.
                                    break;
                                  default:
                                    // Handle other errors here.
                                    break;
                                }
                              }
                            });
                          },
                          child: Transform.rotate(
                              angle: transform,
                              child: const Icon(
                                Icons.flip_camera_ios,
                                size: 25,
                                color: Colors.white,
                              )
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void takePhoto(BuildContext context) async {
    final file = await controller.takePicture();
    print("Photo ==> ${file.path}");
    Navigator.pushNamed(context, RoutesName.camera_view, arguments: file);
  }
}
