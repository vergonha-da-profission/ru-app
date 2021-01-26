import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ru/repository/user_repository.dart';
import 'package:ru/shared/constants.dart';

const ADD_FOUNDS_URL = "$SERVER_URL/api/transaction/add";

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
