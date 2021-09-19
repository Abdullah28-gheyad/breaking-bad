import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://www.breakingbadapi.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    @required String endPoint,
  }) async {
    return await dio.get(endPoint);
  }
}
