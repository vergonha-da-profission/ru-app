import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ru/repository/user_repository.dart';

const ADD_FOUNDS_URL = 'http://10.0.2.2:3000/api/transaction/add';

abstract class TransactionRepository {
  static Future<bool> addFouds({
    @required double value,
    @required String name,
    @required String description,
  }) async {
    final dio = new Dio();
    // final response = await dio.post(ADD_FOUNDS_URL);
    final token = await UserRepository.getToken();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer $token";

    try {
      await dio.post(ADD_FOUNDS_URL, data: {
        "name": name,
        "description": description,
        "value": value,
      });

      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
