import 'package:bookstore/features/StartScreen/ui/app_start_screen.dart';
import 'package:bookstore/features/auth/cubit/auth_cubit.dart';
import 'package:bookstore/features/auth/ui/login_screen.dart';
import 'package:bookstore/features/auth/ui/register_screen.dart';
import 'package:bookstore/features/bottom_nav_bar/ui/bottom_nav_bar.dart';
import 'package:bookstore/features/home/ui/home_screen.dart';
import 'package:bookstore/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/home/cubit/home_cubit.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {


      case Routes.appStartScreen:
        return MaterialPageRoute(
          builder: (_) => const AppStartScreen(),
        );

      case Routes.welcomeScreen:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => AuthCubit(),
                child: LoginScreen(),
              ),
        );

      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const RegisterScreen(),
          ),
        );

      case Routes.bottomNavBarScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(),
              ),
            ],
            child: const BottomNavBar(),
          ),
        );


      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(
            body: Center(
              child: Text('No Route Found'),
            ),
          ),
        );
    }
  }
}