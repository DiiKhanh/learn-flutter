import 'package:dio/dio.dart';
import 'package:my_app/configs/api_config.dart';
import 'package:my_app/data/models/user_model.dart';
import 'package:my_app/data/remotes/dio/dio_client.dart';

class UserApi {
  UserApi._();

  static final UserApi _instance = UserApi._();
  static UserApi get instance => _instance;

  final DioClient _dioClient = DioClient(baseUrl: ApiConfig.baseUrl);

  Future<UserModel> getProfile(String id) async {
    try {
      final response = await _dioClient.get('${ApiEndpoints.userProfile}/$id');

      if (response.statusCode == 200) {
        final data = response.data;
        return UserModel.fromJson(data);
      } else {
        throw Exception(
          'Get profile failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Get profile failed: ${e.response?.data['message'] ?? e.message}',
        );
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<UserModel> updateProfile(String id, UserModel request) async {
    try {
      final response = await _dioClient.put(
        '${ApiEndpoints.userProfile}/$id',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return UserModel.fromJson(data);
      } else {
        throw Exception(
          'Update profile failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Update profile failed: ${e.response?.data['message'] ?? e.message}',
        );
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
