// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> _ar = {
    "login": "تسجيل الدخول",
    "welcomeMessage": "اطلب كتابك الآن!",
    "register": "إنشاء حساب",
    "welcomeBack": "مرحبًا بعودتك! سعداء برؤيتك مرة أخرى!",
    "enterEmail": "أدخل بريدك الإلكتروني",
    "enterPassword": "أدخل كلمة المرور",
    "forgotPassword": "هل نسيت كلمة المرور؟",
    "or": "أو",
    "signInGoogle": "تسجيل الدخول باستخدام جوجل",
    "signInApple": "تسجيل الدخول باستخدام آبل",
    "noAccount": "ليس لديك حساب؟",
    "helloRegister": "مرحبًا! قم بإنشاء حساب للبدء",
    "username": "اسم المستخدم",
    "email": "البريد الإلكتروني",
    "password": "كلمة المرور",
    "confirmPassword": "تأكيد كلمة المرور",
    "haveAccount": "لديك حساب بالفعل؟",
    "register_now": "سجل الآن",
    "send_code": "إرسال الكود",
    "forgot_password": "نسيت كلمة المرور؟",
    "forgot_password_desc":
        "لا تقلق! هذا يحدث. من فضلك أدخل عنوان البريد الإلكتروني المرتبط بحسابك.",
  };
  static const Map<String, dynamic> _en = {
    "login": "Login",
    "welcomeMessage": "Order Your Book Now!",
    "register": "Register",
    "welcomeBack": "Welcome back! Glad to see you, Again!",
    "enterEmail": "Enter your email",
    "enterPassword": "Enter your password",
    "forgotPassword": "Forgot Password?",
    "or": "Or",
    "signInGoogle": "Sign in with Google",
    "signInApple": "Sign in with Apple",
    "noAccount": "Don’t have an account?",
    "helloRegister": "Hello! Register to get started",
    "username": "Username",
    "email": "Email",
    "password": "Password",
    "confirmPassword": "Confirm password",
    "haveAccount": "Already have an account?",
    "register_now": "Register Now",
    "send_code": "Send Code",
    "forgot_password": "Forgot Password?",
    "forgot_password_desc":
        "Don't worry! It occurs. Please enter the email address linked with your account.",
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": _ar,
    "en": _en,
  };
}
