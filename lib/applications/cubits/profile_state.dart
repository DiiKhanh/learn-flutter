import 'package:equatable/equatable.dart';

enum ActiveAccount { activated, deactivated }

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String username;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String nationality;
  final String role;
  final ActiveAccount active;

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
