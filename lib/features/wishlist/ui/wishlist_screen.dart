import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/helper/app_constants.dart';
import '../../../core/routes/routes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');

              AppConstants.token = null;

              if (!context.mounted) return;

              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginScreen,
                    (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );












    //   Center(child: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Text("Wishlist")
    //   ],
    // ));
  }
}