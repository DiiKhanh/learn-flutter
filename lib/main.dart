import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/applications/cubits/login_cubit.dart';
import 'package:my_app/applications/cubits/profile_cubit.dart';
import 'package:my_app/configs/navigation.dart';
import 'package:my_app/data/repositories/authen_repository_imp.dart';
import 'package:my_app/data/repositories/user_repository_imp.dart';
import 'package:my_app/presentation/screens/edit_profile_screen.dart';
import 'package:my_app/presentation/screens/login_screen.dart';
import 'package:my_app/presentation/screens/profile_screen.dart';
import 'package:my_app/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _authenRepository = AuthenRepositoryImp();
  static final _userRepository = UserRepositoryImp();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenRepository),
        RepositoryProvider.value(value: _userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>(
            create:
                (context) => ProfileCubit(
                  userRepository: context.read<UserRepositoryImp>(),
                ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: Navigation.loginScreen,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Navigation.loginScreen:
        return _buildRoute(
          BlocProvider(
            create:
                (context) => LoginCubit(
                  authenRepository: context.read<AuthenRepositoryImp>(),
                ),
            child: const LoginScreen(),
          ),
        );

      case Navigation.profileScreen:
        return _buildRoute(
          Builder(
            builder: (context) {
              final userId = settings.arguments as String? ?? '4';
              context.read<ProfileCubit>().loadProfile(userId);
              return const ProfileScreen();
            },
          ),
        );

      case Navigation.editProfileScreen:
        return _buildRoute(const EditProfileScreen());

      default:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }

  static MaterialPageRoute _buildRoute(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}
