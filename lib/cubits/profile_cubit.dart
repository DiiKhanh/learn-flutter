import 'package:equatable/equatable.dart';

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
