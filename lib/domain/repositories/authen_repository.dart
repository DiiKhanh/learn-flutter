import 'package:my_app/data/models/auth_model.dart';

abstract class AuthenRepository {
  Future<String> login(AuthModel auth);
}
