import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadProfile() async {
    try {
      emit(ProfileLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(
        ProfileLoaded(
          username: 'hoangnguyen18',
          name: 'Hoang Nguyen',
          email: 'hoang.nguyen@stacktech.org',
          phone: '+84912885565',
          address: 'Huynh Tan Phat Street, District 7',
          nationality: 'China',
          role: 'Operator Admin',
          active: ActiveAcount.activated,
        ),
      );
    } catch (e) {
      emit(const ProfileError('Failed to load profile'));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String nationality,
  }) async {
    try {
      emit(EditProfileLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(const EditProfileUpdated('Profile updated successfully!'));
      emit(
        ProfileLoaded(
          username: 'hoangnguyen18',
          name: name,
          email: email,
          phone: phone,
          address: address,
          nationality: nationality,
          role: 'Admin',
          active: ActiveAcount.activated,
        ),
      );
    } catch (e) {
      emit(const EditProfileError('Failed to update profile'));
    }
  }
}

class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

enum ActiveAcount { activated, deactivated }

class ProfileLoaded extends ProfileState {
  final String username;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String nationality;
  final String role;
  final ActiveAcount active;

  const ProfileLoaded({
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.nationality,
    required this.role,
    required this.active,
  });

  @override
  List<Object?> get props => [
    username,
    name,
    email,
    phone,
    address,
    nationality,
    role,
    active,
  ];
}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class EditProfileLoading extends ProfileState {}

class EditProfileError extends ProfileState {
  final String message;

  const EditProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class EditProfileUpdated extends ProfileState {
  final String message;

  const EditProfileUpdated(this.message);

  @override
  List<Object?> get props => [message];
}
