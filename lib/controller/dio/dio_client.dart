import 'package:bioreino_mobile/controller/dio/dao/student_dao.dart';
import 'package:bioreino_mobile/controller/dio/private/credentials.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioClient {
  DioClient() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: APICredentials.defaultUrl,
      ),
    );
  }

  static Dio? _dio;

  Future<Response?> get(String endpoint,
      {String logId = "GET", String? token}) async {
    try {
      final response = await _dio!.get(
        endpoint,
        options: Options(
          headers: {
            "Authorization": "Bearer ${token ?? StudentDAO.student?.token}",
          },
        ),
      );
      Logger().i("GET (${response.realUri}) - $logId:\n\n${response.data}");
      return response;
    } catch (e) {
      Logger().e("Error GET - $logId:\n\n$e");
      return null;
    }
  }

  Future<Response?> post(
    String endpoint,
    dynamic data, {
    String logId = "POST",
    String? token,
  }) async {
    try {
      final response = await _dio!.post(
        endpoint,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer ${token ?? StudentDAO.student?.token}",
          },
        ),
      );
      Logger().i("POST (${response.realUri}) - $logId:\n\n${response.data}");
      return response;
    } catch (e) {
      Logger().e("Error POST - $logId:\n\n$e");
      return null;
    }
  }
}
