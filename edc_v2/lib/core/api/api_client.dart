import 'package:dio/dio.dart';
import 'package:edc_v2/core/api/api_config.dart';
import 'package:edc_v2/core/api/token/token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  Dio getDio({bool tokenInterceptor = false}) {
    Dio dio = Dio();
    dio.options.baseUrl = '${ApiConfig.BASE_URL}api/';
    
    // Add default headers and timeout
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if(tokenInterceptor){
      dio.interceptors.add(TokenInterceptor(dio: dio));
    }
  
    dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      compact: false,
    ));

    return dio;
  }
}