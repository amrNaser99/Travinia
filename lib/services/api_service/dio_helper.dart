import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:travinia/core/error/exceptions.dart';

abstract class DioHelper {
  Future<dynamic> post({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    dynamic options,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });
}

extension RequestFunction on DioHelper {
  Future request({
    required Future<Response> Function() call,
  }) async {
    try {
      final r = await call.call();
      debugPrint("Response_Data => ${r.data}");
      debugPrint("Response_Code => ${r.statusCode}");

      if (r.data['status']['type'] == '0') {
        dynamic title = r.data['status']['title'];

        throw PrimaryServerException(
          message: title is String ? title : r.data['status']['title']['ar'],
          code: r.statusCode ?? 500,
          error: title is String ? title : r.data['status']['title']['en'],
        );
      }

      return r.data;
    } on DioError catch (e) {
      debugPrint("Error_Message => ${e.message}");
      debugPrint("Error_Error => ${e.error.toString()}");
      debugPrint("Error_Type => ${e.type.toString()}");

      throw PrimaryServerException(
        code: 100,
        error: 'error message',
        message: 'message Hello from primary exception',
      );
    } catch (e) {
      PrimaryServerException exception = e as PrimaryServerException;

      throw PrimaryServerException(
        code: exception.code,
        error: exception.error,
        message: exception.message,
      );
    }
  }
}
