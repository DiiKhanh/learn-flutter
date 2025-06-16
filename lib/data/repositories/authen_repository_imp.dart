import 'package:my_app/data/models/auth_model.dart';
import 'package:my_app/data/resources/auth_api.dart';
import 'package:my_app/domain/repositories/authen_repository.dart';

class AuthenRepositoryImp implements AuthenRepository {
  final AuthApi _authApi = AuthApi.instance;
  @override
  Future<String> login(AuthModel auth) async {
    try {
      final token = await _authApi.login(auth);
      return token;
    } catch (e) {
      rethrow;
    }
  }
}
