import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ru/repository/user_repository.dart';
import 'package:ru/shared/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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

  static Future<BankSilk> bankSilk({
    @required double value,
  }) async {
    final dio = new Dio();

    final token = await UserRepository.getToken();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer $token";

    try {
      final res = await dio.get(ADD_FOUNDS_BANK_SILK, queryParameters: {
        "value": value,
      });

      final pasedData = res.data["bill"];

      final publicDir = await getTemporaryDirectory();
      final path = "${publicDir.path}/${Uuid().v4()}.pdf";

      final bank = BankSilk(
        code: pasedData['code'],
        pdfBuffer: pasedData['pdf'].cast<int>(),
        path: path,
      );

      final file = await new File(path).create();
      file.writeAsBytesSync(bank.pdfU);

      return bank;
    } on Exception catch (_) {
      return null;
    }
  }
}

class BankSilk {
  final List<int> pdfBuffer;
  final String code;
  final String path;

  BankSilk({this.pdfBuffer, this.code, this.path});

  Uint8List get pdfU {
    return Uint8List.fromList(pdfBuffer);
  }
}
