import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/applications/cubits/profile_state.dart';
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
          active: ActiveAccount.activated,
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
          active: ActiveAccount.activated,
        ),
      );
    } catch (e) {
      emit(EditProfileError((e.toString())));
    }
  }
}
