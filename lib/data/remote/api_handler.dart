import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'api_response.dart';

class HandlingResponse {
  static ApiResponse returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponse.completed(response);
      case 400:
        return ApiResponse.error('Bad Request');
      case 401:
        return ApiResponse.unAuthorised('Unauthorized');
      case 403:
        return ApiResponse.error('Access Forbidden');
      case 404:
        return ApiResponse.error('Not Found');
      case 500:
        return ApiResponse.error('Internal Server Error');
      default:
        return ApiResponse.error('Some Error Occured');
    }
  }

  static ApiResponse returnException(Object exception) {
    if (exception is SocketException) {
      return ApiResponse.noInternet('No Internet: $exception');
    } else if (exception is TimeoutException) {
      return ApiResponse.timeout('Timeout : $exception');
    } else {
      return ApiResponse.error('Some Error Occured :$exception');
    }
  }
}
