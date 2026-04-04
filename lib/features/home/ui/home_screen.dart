import 'package:bookstore/features/home/ui/widgets/home_app_bar.dart';
import 'package:bookstore/features/home/ui/widgets/home_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppBar(),
        HomeSlider()
      ],
    );
  }
}





