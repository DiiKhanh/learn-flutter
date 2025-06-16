import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/data/models/user_model.dart';
import 'package:my_app/domain/repositories/user_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit({required UserRepository userRepository})
    : userRepository = userRepository,
      super(ProfileInitial());

  Future<void> loadProfile(String id) async {
    emit(ProfileLoading());
    try {
      final data = await userRepository.getProfile(id);
      emit(
        ProfileLoaded(
          username: data.username!,
          name: '${data.name?.firstName} ${data.name?.lastName}',
          email: data.email!,
          phone: data.phone!,
          address: '${data.address.street}',
          nationality: '${data.address.city}',
          role: 'Operator Admin',
          active: ActiveAcount.activated,
        ),
      );
    } catch (e) {
      emit(ProfileError((e.toString())));
    }
  }

  Future<void> updateProfile({required UserModel request}) async {
    emit(EditProfileLoading());
    try {
      final user = UserModel(
        email: request.email,
        phone: request.phone,
        address: Address(request.address.city, request.address.street),
        name: Name(request.name?.firstName, request.name?.lastName),
        username: request.username,
      );

      final data = await userRepository.updateProfile('4', user);
      emit(
        ProfileLoaded(
          username: data.username!,
          name: '${data.name?.firstName} ${data.name?.lastName}',
          email: data.email!,
          phone: data.phone!,
          address: '${data.address.street}',
          nationality: '${data.address.city}',
          role: 'Operator Admin',
          active: ActiveAcount.activated,
        ),
      );
    } catch (e) {
      emit(EditProfileError((e.toString())));
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
