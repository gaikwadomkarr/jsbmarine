import 'package:dio/dio.dart';
import 'package:jsbmarineversion1/api/custom_exception.dart';

import '../utils/string_constant.dart';

class ApiBasicCalls {
  static ApiBasicCalls _instance = new ApiBasicCalls.internal();

  static ApiBasicCalls getInstance() {
    return _instance;
  }

  ApiBasicCalls.internal();

  factory ApiBasicCalls() {
    return _instance;
  }

  /**
   * Get Api Call here....
   */

  Future<dynamic> get(String url) async {
    String token = 'Bearer ' + TOKEN;
    BaseOptions options = BaseOptions(
      responseType: ResponseType.json,
      baseUrl: BASEURL,
      headers: <String, dynamic>{'Authorization': token},
    );
    Dio _dio = Dio(options);
    var responseJson;
    try {
      final response = await _dio.get(url);
      print(response);
      responseJson = _response(response);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print(errorMessage);
      responseJson = e.response!.data;
    }
    return responseJson;
  }

  /**
   * Post Api Call here....
   */
  Future<dynamic> post(String url, Map<String, dynamic> map) async {
    String token = 'Bearer ' + TOKEN;
    BaseOptions options = BaseOptions(
      baseUrl: BASEURL,
      headers: <String, dynamic>{'Authorization': token},
    );
    Dio _dio = Dio(options);
    var responseJson;
    try {
      final response = await _dio.post(url, data: FormData.fromMap(map));
      responseJson = _response(response);
//      print(responseJson);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print(errorMessage);
      responseJson = e.response!.data;
    }
    return responseJson;
  }

  /**
   * Put Api Call  here....
   */
  Future<dynamic> put(
      String url, Map<String, dynamic> map, String uerid) async {
    String token = 'Bearer ' + TOKEN;
    BaseOptions options = BaseOptions(
      baseUrl: BASEURL,
      headers: <String, dynamic>{
        'Authorization': token,
      },
    );
    Dio _dio = Dio(options);
    var responseJson;
    try {
      final response =
          await _dio.put(url + '/$uerid', data: new FormData.fromMap(map));
      responseJson = _response(response);
//      print(responseJson);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print(errorMessage);
      responseJson = e.response!.data;
    }
    return responseJson;
  }

  /**
   * Post Api Call without token here....
   */

  Future<dynamic> postWithoutToken(String url, Map<String, dynamic> map) async {
    print(BASEURL);
    BaseOptions options =
        BaseOptions(baseUrl: BASEURL, responseType: ResponseType.json);

    Dio _dio = Dio(options);
    var responseJson;
    try {
      final response = await _dio.post(url, data: FormData.fromMap(map));
      print("this is register response => $response");
      responseJson = _response(response);
    } on DioError catch (e) {
      print("this is register response error => $e");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print(errorMessage);
      if (e.response != null) responseJson = e.response!.data;
    }
    return responseJson;
  }

  Dio getDioWithoutToken(String requestType) {
    BaseOptions options =
        BaseOptions(baseUrl: BASEURL, responseType: ResponseType.json);
    Dio dio = new Dio(options);
    dio.options.followRedirects = false;
    if (requestType == "json") {
      dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
      dio.options.headers['Accept'] = 'application/json';
    } else if (requestType == "formdata") {
      print("inside formData");
      dio.options.headers['Content-Type'] = 'multipart/form-data';
      dio.options.headers['Accept'] = 'application/json';
    }
    //dio.interceptors.add(DioFirebasePerformanceInterceptor());
    dio.options.responseType = ResponseType.json;

    return dio;
  }

  Dio getDio(String requestType) {
    Dio dio = new Dio();
    dio.options.baseUrl = BASEURL;
    dio.options.followRedirects = false;
    if (requestType == "json") {
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Accept'] = 'application/json';
    } else if (requestType == "formdata") {
      print("inside formData");
      dio.options.headers['Content-Type'] = 'multipart/form-data';
      dio.options.headers['Accept'] = 'application/json';
    }

    if (TOKEN != '') {
      dio.options.headers['Authorization'] = 'Bearer ' + TOKEN;
    }
    //dio.interceptors.add(DioFirebasePerformanceInterceptor());
    dio.options.responseType = ResponseType.json;

    return dio;
  }

  /**
   * Responce Handler...  
   */
  dynamic _response(Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class DioExceptions implements Exception {
  String message = "";

  DioExceptions.fromDioError(DioError dioError) {
    print(dioError.type);
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response!.statusCode, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error["message"];
      case 403:
        return error["message"];
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
