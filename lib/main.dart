import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubits/login_cubit.dart';
import 'package:my_app/cubits/profile_cubit.dart';
import 'package:my_app/data/repositories/authen_repository_imp.dart';
import 'package:my_app/screens/edit_profile_screen.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/profile_screen.dart';
import 'package:my_app/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: '/',
        onGenerateRoute: (route) {
          switch (route.name) {
            case '/':
              return MaterialPageRoute(
                builder:
                    (_) => BlocProvider(
                      create:
                          (_) => LoginCubit(
                            authenRepository: AuthenRepositoryImp(),
                          ),
                      child: const LoginScreen(),
                    ),
              );
            case '/profile':
              return MaterialPageRoute(
                builder: (context) {
                  context.read<ProfileCubit>().loadProfile();
                  return const ProfileScreen();
                },
              );
            case '/edit-profile':
              return MaterialPageRoute(
                builder: (_) => const EditProfileScreen(),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
