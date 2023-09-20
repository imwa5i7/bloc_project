import 'dart:convert';

import 'package:job_task/config/constants.dart';
import 'package:job_task/data/models/auth_requests.dart';
import 'package:job_task/data/remote/api_service.dart';
import 'package:http/http.dart' as http;
import '../models/auth_responses.dart';
import '../remote/api_handler.dart';
import '../remote/api_response.dart';

class AuthenticationRepository {
  final ApiService _apiService;
  AuthenticationRepository(this._apiService);

  Future<ApiResponse> login(LoginRequest request) async {
    try {
      http.Response response = await _apiService.post(
          '/admin/users/login',
          {
            'email': request.email,
            'password': request.password,
          },
          baseURL: Constants.authBaseUrl);
      ApiResponse result = HandlingResponse.returnResponse(response);
      if (result.status == Status.completed) {
        Authentication auth = authenticationFromJson(response.body);
        if (auth.success!) {
          result = ApiResponse.completed(auth);
        } else {
          result = ApiResponse.error(auth.message);
        }
      }
      return result;
    } catch (err) {
      ApiResponse response = HandlingResponse.returnException(err);
      return response;
    }
  }

  Future<ApiResponse> register(RegisterRequest request) async {
    try {
      http.Response response = await _apiService.post(
          '/admin/users/reg',
          {
            "first_name": request.firstName,
            "last_name": request.lastName,
            "email": request.email,
            "password": request.password,
            "contact": "03131122334"
          },
          baseURL: Constants.authBaseUrl);
      ApiResponse result = HandlingResponse.returnResponse(response);
      if (result.status == Status.completed) {
        var data = jsonDecode(response.body)!;
        bool success = data['success'];
        if (success) {
          result = ApiResponse.completed(data['message']);
        } else {
          result = ApiResponse.error(data['message']);
        }
      }
      return result;
    } catch (err) {
      ApiResponse response = HandlingResponse.returnException(err);
      return response;
    }
  }
}
