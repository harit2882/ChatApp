import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Object exception;
  const ErrorPage({Key? key, required this.exception}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Text("Error : ${exception.toString()}"),
      );
  }
}
