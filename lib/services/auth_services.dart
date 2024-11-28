import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/authentication', // Your server base URL
      // connectTimeout: const Duration(seconds: 10),
      // receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(PrettyDioLogger(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    compact: false,
  ));

  // Register Function
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        '/register/',
        data: {
          "username": username,
          "email": email,
          "password": password,
          "confirm_password": confirmPassword,
        },
      );
      return response.data; // Returns JSON response (success or error)
    } on DioException catch (e) {
      if (e.response != null) {
        return {
          'error': true,
          'message': e.response?.data['error'] ?? 'Something went wrong',
        };
      } else {
        return {
          'error': true,
          'message': 'Unable to connect to the server',
        };
      }
    }
  }

  // Login Function
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/login/',
        data: {
          "username": username,
          "password": password,
        },
      );
      return response.data; // Returns JSON response (success or error)
    } on DioException catch (e) {
      if (e.response != null) {
        return {
          'error': true,
          'message': e.response?.data['error'] ?? 'Something went wrong',
        };
      } else {
        return {
          'error': true,
          'message': 'Unable to connect to the server',
        };
      }
    }
  }
}
