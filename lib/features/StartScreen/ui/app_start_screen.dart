import 'package:bookstore/core/helper/app_constants.dart';
import 'package:bookstore/core/routes/routes.dart';
import 'package:flutter/material.dart';

class AppStartScreen extends StatefulWidget {
  const AppStartScreen({super.key});

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  void _goNext() {
    Future.microtask(() {
      final token = AppConstants.token;

      if (token == null || token.trim().isEmpty) {
        Navigator.pushReplacementNamed(context, Routes.loginScreen);
      } else {
        Navigator.pushReplacementNamed(context, Routes.bottomNavBarScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}