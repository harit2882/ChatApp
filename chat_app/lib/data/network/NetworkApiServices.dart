import 'dart:convert';
import 'dart:io';


import 'package:chat_app/data/app_exception.dart';
import 'package:chat_app/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;


class NetworkApiServices implements BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
      case 500:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException(
            "Error accorded while communication with server with status code ${response.statusCode.toString()}");
    }
  }
}
