import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/features/auth/ui/login_screen.dart';
import 'package:bookstore/features/auth/ui/register_screen.dart';
import 'package:bookstore/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal:22.w ),
        decoration: BoxDecoration(image: DecorationImage(image:Assets.images.welcomeBackground.image().image,
        fit: BoxFit.cover
        ),),
        child: Column(children: [
          SizedBox(height: 35.h,),
          Row(
            children: [
              IconButton(onPressed: (){if(context.locale.languageCode=="ar"){
                context.setLocale(Locale("en"));
              }else{
                context.setLocale(Locale("ar"));}}, icon: Icon(Icons.language)),
            ],
          ),
          SizedBox(height: 100.h,),
          Assets.images.splash.image(),
          SizedBox(height: 28.h,),
          Expanded(
            child: Text(LocaleKeys.welcomeMessage.tr(),
            style: TextStyle(
              fontSize: 20.sp,
            ),
            ),
          ),

          AppButton(text: LocaleKeys.login.tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
          SizedBox(height: 15.h,),
          AppButton(text: LocaleKeys.register.tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
              );
            },
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 94.h,)
          

          
        ],),
    )
    );
  }
}
