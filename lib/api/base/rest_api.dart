import 'dart:developer';

import 'package:dio/dio.dart';

class RestAPI {
  static final RestAPI _instance = RestAPI._internal();

  factory RestAPI() => _instance;

  static RestAPI get shared => _instance;

  RestAPI._internal();
  final Dio dio = Dio();

  Future<Response> getData(String endpoint) async {
    log('get endpoint: $endpoint');
    try {
      Response response = await dio.get(endpoint);
      return response;
    } catch (error, stacktrace) {
      log('Exception occured: $error stackTrace: $stacktrace');
      return Response(
          data: {"error": "Request failed"},
          requestOptions: RequestOptions(path: endpoint));
    }
  }

  Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await dio.post(endpoint, data: data);
      return response;
    } catch (error, stacktrace) {
      log('Exception occured: $error stackTrace: $stacktrace');
      return Response(
          data: {"error": "Request failed"},
          requestOptions: RequestOptions(path: endpoint));
    }
  }

  Future<Response> postDataWithFormData(
      String endpoint, Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response response = await dio.post(endpoint,
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));
      return response;
    } catch (error, stacktrace) {
      log('Exception occured: $error stackTrace: $stacktrace');
      return Response(
          data: {"error": "Request failed"},
          requestOptions: RequestOptions(path: endpoint));
    }
  }

  Future<Response> putData(String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await dio.put(endpoint, data: data);
      return response;
    } catch (error, stacktrace) {
      log('Exception occured: $error stackTrace: $stacktrace');
      return Response(
          data: {"error": "Request failed"},
          requestOptions: RequestOptions(path: endpoint));
    }
  }

  Future<Response> deleteData(String endpoint) async {
    try {
      Response response = await dio.delete(endpoint);
      return response;
    } catch (error, stacktrace) {
      log('Exception occured: $error stackTrace: $stacktrace');
      return Response(
          data: {"error": "Request failed"},
          requestOptions: RequestOptions(path: endpoint));
    }
  }
}
