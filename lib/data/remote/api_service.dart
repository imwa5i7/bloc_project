import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../config/constants.dart';

class ApiService {
  static const baseurl = Constants.baseUrl;

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<http.Response> get(String url, {String baseUrl = baseurl}) async {
    log(baseUrl + url, name: 'Get URl');
    final response = await http.get(
      Uri.parse(baseUrl + url),
      headers: _headers,
    );
    return response;
  }

  Future<http.Response> post(String url, dynamic body,
      {String baseURL = baseurl}) async {
    log(baseURL + url, name: 'Post URl');
    final response = await http.post(
      Uri.parse(baseURL + url),
      headers: _headers,
      body: jsonEncode(body),
    );
    return response;
  }
}
