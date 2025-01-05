import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils{

  static showSnackBar(String message,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static Future<File?> pickImageFromGallery(BuildContext context) async{

    File? image;
    try{
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(pickedImage!=null){
        image = File(pickedImage.path);
      }

    } catch (e){
      showSnackBar(e.toString(), context);
    }
    return image;
  }

  static Widget progressBar(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  //get last message time (used in chat user card)
  static String getLastMessageTime(
      {required BuildContext context,
        required DateTime time,
        bool showYear = false}) {
    final now = DateTime.now();

    if (now.day == time.day &&
        now.month == time.month &&
        now.year == time.year) {
      return TimeOfDay.fromDateTime(time).format(context);
    }

    return now.year != time.year
        ? '${time.day} ${_getMonth(time)} ${time.year}'
        : '${time.day} ${_getMonth(time)}';
  }

  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';

      case 2:
        return 'Feb';

      case 3:
        return 'Mar';

      case 4:
        return 'Apr';

      case 5:
        return 'May';

      case 6:
        return 'Jun';

      case 7:
        return 'Jul';

      case 8:
        return 'Aug';

      case 9:
        return 'Sep';

      case 10:
        return 'Oct';

      case 11:
        return 'Nov';

      case 12:
        return 'Dec';
    }
    return 'N/A';
  }

}