import 'package:my_app/data/models/user_model.dart';
import 'package:my_app/data/resources/user_api.dart';
import 'package:my_app/domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserApi _userApi = UserApi.instance;
  @override
  Future<UserModel> getProfile(String id) async {
    try {
      final data = await _userApi.getProfile(id);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> updateProfile(String id, UserModel request) async {
    try {
      final data = await _userApi.updateProfile(id, request);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
