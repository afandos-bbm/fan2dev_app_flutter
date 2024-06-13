import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';

/// Client for making HTTP request using Dio.
/// It is used to make HTTP requests to the backend.
///
/// This class is a [Dio].
class DioClient {
  const DioClient(Dio dio) : _dio = dio;
  final Dio _dio;

  void initDio() {
    // Set default configs
    _dio.options.connectTimeout = const Duration(seconds: 8);
    _dio.options.responseType = ResponseType.json;

    // Add interceptors
    _dio.interceptors.addAll([
      TalkerDioLogger(),
    ]);
  }

  Dio get dio => _dio;
}
