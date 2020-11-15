import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
            'https://reqres.in/api/login',
            headers: headers,
            body: jsonEncode({
              "email": username,
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
      print(error);
      throw error;
    }
  }

  static Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  static Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  static Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
