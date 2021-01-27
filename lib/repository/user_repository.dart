import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ru/models/user.dart';
import 'package:ru/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

const LOGIN_URL = "$SERVER_URL/api/auth/login";
const GET_PROFILE_URL = "$SERVER_URL/api/user/profile";

abstract class UserRepository {
  static Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    const headers = {
      'Content-Type': 'application/json',
    };

    try {
      final res = await http
          .post(
            LOGIN_URL,
            headers: headers,
            body: jsonEncode({
              "username": username,
              "password": password,
            }),
          )
          .timeout(Duration(seconds: 10));

      if (res.statusCode != 200 && res.statusCode != 400)
        throw Exception('http.post error: statusCode= ${res.statusCode}');

      // Password or user incorrect
      if (res.statusCode == 400) return null;

      final decodedResponse = jsonDecode(res.body)["token"];

      return decodedResponse;
    } catch (error) {
      throw error;
    }
  }

  static Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  static Future<void> persistToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    return;
  }

  static Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    return token != null;
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    return token;
  }

  static Future<dynamic> getUserData(String token) async {
    Dio dio = new Dio();

    dio.options.headers["authorization"] = "Bearer $token";

    final response = await dio.get(GET_PROFILE_URL);

    final a = User.fromJson(response.data);

    return (a);
  }
}
