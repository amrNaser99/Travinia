import 'package:dio/dio.dart';

class DioTest {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'http://api.mahmoudtaha.com/api/',
          receiveDataWhenStatusError: true,
          //connectTimeout: 20 * 1000,
          //receiveTimeout: 20 * 1000,
          headers: {
            'token':
                'lDskjVorwaBlDmi1uW2LUJKRBU4DRFZxmTtCGv4hnAfnivtCZeiszUxeyIaK',
          }),
    );
  }

  static Future<Response> getBooking() {
    return dio!.get("get-bookings", queryParameters: {
      "type": "completed",
    });
  }

  static Future<Response> createBooking() {
    return dio!.post("create-booking", data: {
      "user_id": 300,
      "hotel_id": 9,
    });
  }
}
