import 'package:bookstore/features/StartScreen/ui/app_start_screen.dart';
import 'package:bookstore/features/auth/cubit/auth_cubit.dart';
import 'package:bookstore/features/auth/ui/forgot_password_screen.dart';
import 'package:bookstore/features/auth/ui/login_screen.dart';
import 'package:bookstore/features/auth/ui/register_screen.dart';
import 'package:bookstore/features/bottom_nav_bar/ui/bottom_nav_bar.dart';
import 'package:bookstore/features/home/ui/home_screen.dart';
import 'package:bookstore/features/welcome/welcome_screen.dart';
import 'package:bookstore/features/notifications/ui/notifications_screen.dart';
import 'package:bookstore/features/profile/ui/edit_profile_screen.dart';
import 'package:bookstore/features/profile/ui/my_orders_screen.dart';
import 'package:bookstore/features/profile/cubit/order_cubit.dart';
import 'package:bookstore/features/profile/ui/reset_password_screen.dart';
import 'package:bookstore/features/support/cubit/support_cubit.dart';
import 'package:bookstore/features/support/ui/contact_us_screen.dart';
import 'package:bookstore/features/support/ui/faq_screen.dart';
import 'package:bookstore/features/support/ui/privacy_terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/home/cubit/home_cubit.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.appStartScreen:
        return MaterialPageRoute(builder: (_) => const AppStartScreen());

      case Routes.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
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

      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const ForgotPasswordScreen(),
          ),
        );

      case Routes.bottomNavBarScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
            ],
            child: const BottomNavBar(),
          ),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.myOrdersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OrderCubit()..getOrders(),
            child: const MyOrdersScreen(),
          ),
        );

      case Routes.editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case Routes.notificationsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      case Routes.faqScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SupportCubit()..loadFaqs(),
            child: const FaqScreen(),
          ),
        );

      case Routes.contactUsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SupportCubit(),
            child: const ContactUsScreen(),
          ),
        );

      case Routes.privacyTermsScreen:
        return MaterialPageRoute(builder: (_) => const PrivacyTermsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No Route Found'))),
        );
    }
  }
}
