import 'package:dio/dio.dart';

class ApiResponse {
  dynamic data;

  ApiResponse.parse(Response response) {
    if (response.statusCode == 200) {
      data = response;
    } else {
      throw const FormatException();
    }
  }
}
