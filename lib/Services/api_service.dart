import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: "https://corsproxy.io/?https://api.deezer.com/",
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {"Accept": "application/json"},
        ),
      );

  Future<Response> get(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      throw Exception("فشل الاتصال بالخادم: ${e.message}");
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع: $e");
    }
  }
}
