import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@example.com' && password == 'password') {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure('Invalid credentials'));
    }
  }
}

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}
