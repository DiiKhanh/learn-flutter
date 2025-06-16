import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/data/models/auth_model.dart';
import 'package:my_app/domain/repositories/authen_repository.dart';
import 'package:my_app/utils/shared_prefs.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenRepository authenRepository;
  static const String _tokenKey = 'auth_token';

  LoginCubit({required AuthenRepository authenRepository})
    : authenRepository = authenRepository,
      super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final authModel = AuthModel(accountName: email, password: password);

      final token = await authenRepository.login(authModel);

      if (token.isNotEmpty) {
        emit(LoginSuccess(token: token));
        _saveAuthData(token);
      } else {
        emit(LoginFailure('Authentication failed - no token received'));
      }
    } catch (e) {
      emit(LoginFailure((e.toString())));
    }
  }

  Future<void> _saveAuthData(String token) async {
    await SharedPrefs.init();
    await SharedPrefs.setString(_tokenKey, token);
  }
}

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({required this.token});

  @override
  List<Object> get props => [token];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}
