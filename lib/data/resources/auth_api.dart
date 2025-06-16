import 'package:dio/dio.dart';
import 'package:my_app/configs/api_config.dart';
import 'package:my_app/data/models/auth_model.dart';
import 'package:my_app/data/remotes/dio/dio_client.dart';

class AuthApi {
  AuthApi._();

  static final AuthApi _instance = AuthApi._();
  static AuthApi get instance => _instance;

  final DioClient _dioClient = DioClient(baseUrl: ApiConfig.baseUrl);

  Future<String> login(AuthModel authModel) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: authModel.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['token'] ?? '';
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Login failed: ${e.response?.data['message'] ?? e.message}',
        );
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
