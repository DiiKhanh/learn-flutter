import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/data/models/auth_model.dart';
import 'package:my_app/domain/repositories/authen_repository.dart';
import 'package:my_app/utils/shared_prefs.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenRepository authenRepository;

  LoginCubit({required this.authenRepository}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final authModel = AuthModel(accountName: email, password: password);

      final token = await authenRepository.login(authModel);

      if (token.isNotEmpty) {
        emit(LoginSuccess(token: token));
        await _saveAuthData(token);
      } else {
        emit(LoginFailure('Authentication failed - no token received'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _saveAuthData(String token) async {
    await SharedPrefs.init();
    await SharedPrefs.setString(Constants.authTokenKey, token);
  }
}
