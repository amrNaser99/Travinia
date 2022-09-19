import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:travinia/services/api_service/end_points.dart';

import 'dio_helper.dart';

class DioImpl extends DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: '${BASE_URL}${API_VERSION}',
      receiveDataWhenStatusError: true,
      connectTimeout: 5000,
    ),
  );

  @override
  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    _checkTimeOutAndSetToDioOptions(timeOut);
    dio.options.headers = _setHeaders(isMultipart, token);
    _debugPrintData(endPoint, data, query);

    return await request(
      call: () async => await dio.get(
        endPoint,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
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
  }) async {
    _checkTimeOutAndSetToDioOptions(timeOut);
    dio.options.headers = _setHeaders(isMultipart, token);
    _debugPrintData(endPoint, data, query);

    return await request(
      call: () async => await dio.post(
        endPoint,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
      ),
    );
  }

  _checkTimeOutAndSetToDioOptions(timeOut) {
    if (timeOut != null) {
      dio.options.connectTimeout = timeOut;
    }
  }

  _setHeaders(bool isMultipart, String? token) {
    return {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (token != null) 'token': token,
    };
  }

  _debugPrintData(String endPoint, data, query) {
    debugPrint('URL => ${dio.options.baseUrl + endPoint}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');
  }
}
