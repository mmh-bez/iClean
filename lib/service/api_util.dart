import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:i_clean/utils/const.dart';

class ApiUtil {
  static Dio apiWithNoAuth = Dio();
  static Dio apiWithAuth = Dio();

  static Future<Dio> connectNoAuth(BuildContext context) async {
    initUrl(context);
    return apiWithNoAuth;
  }

  static Future<Dio> connectWithAuth(BuildContext context) async {
     initUrlWithAuth(context, token);
     return apiWithAuth;
  }

  static Dio initUrl(BuildContext context) {

    // Set default configs
    apiWithNoAuth.options.baseUrl = baseApi;
    apiWithNoAuth.options.connectTimeout = Duration(seconds: 20) ; //20s
    apiWithNoAuth.options.receiveTimeout = Duration(seconds: 20) ; //10s

    apiWithNoAuth.interceptors.add(LogInterceptor(requestBody: true));
    apiWithNoAuth.interceptors.add(LogInterceptor(responseBody: true));
    apiWithNoAuth.options.responseType = ResponseType.plain;
    apiWithNoAuth.options.headers['Content-Type'] = 'application/json';
    apiWithNoAuth.options.headers['Abp.TenantId'] = '1';
    apiWithNoAuth.options.validateStatus = ((code){
  if(code == 500){
        showAlertDialog(context, "Error", "Internal Server Error.Please try again later.", (){
          Navigator.pop(context);
        });
        return false;
      }
      return true;
    });
    apiWithNoAuth.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      // return  handler.next(e);//continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
    return apiWithNoAuth;
  }

  static Dio initUrlWithAuth(BuildContext context, String token) {
    apiWithAuth = new Dio();
    // Read value
    // Set default configs
    apiWithAuth.options.baseUrl = baseApi;
    apiWithAuth.options.connectTimeout = Duration(seconds: 20); //20s
    apiWithAuth.options.receiveTimeout = Duration(seconds: 20); //10s

    apiWithAuth.interceptors.add(LogInterceptor(requestBody: true));
    apiWithAuth.interceptors.add(LogInterceptor(responseBody: true));
    apiWithAuth.options.responseType = ResponseType.plain;
    apiWithAuth.options.headers['Accept'] = 'application/json';
    apiWithAuth.options.headers['Authorization'] = 'Bearer ' + token;
    apiWithAuth.options.validateStatus = ((code){
      return true;
    });
    return apiWithAuth;
  }
}
