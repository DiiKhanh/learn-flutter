import 'package:my_app/data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> getProfile(String id);
  Future<UserModel> updateProfile(String id, UserModel request);
}
