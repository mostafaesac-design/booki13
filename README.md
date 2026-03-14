# Bookia

Bookia is a Flutter application for browsing books with a clean and modern user experience.  
The app includes authentication flow, password recovery flow, and a scalable structure prepared for API integration and feature expansion.

## Features

- Clean and responsive UI
- Login and Register screens
- Forgot Password flow
- OTP Verification
- Create New Password
- Password Changed confirmation
- Multi-language support
- Reusable core widgets
- Feature-based project structure
- Ready for backend/API integration

## Tech Stack

- Flutter
- Dart
- flutter_screenutil
- easy_localization
- Reusable Core Components
- Feature-first architecture

## Screenshots

### Welcome Screens

<p align="center">
  <img src="Screenshots/welcome.png" width="220"/>
  <img src="Screenshots/welcome_ar.png" width="220"/>
</p>

### Authentication

<p align="center">
  <img src="Screenshots/login.png" width="220"/>
  <img src="Screenshots/register.png" width="220"/>
</p>

### Password Recovery Flow

<p align="center">
  <img src="Screenshots/forgot_password.png" width="220"/>
  <img src="Screenshots/otp_verification.png" width="220"/>
  <img src="Screenshots/create_new_password.png" width="220"/>
  <img src="Screenshots/password_changed.png" width="220"/>
</p>

### More Screens

<p align="center">
  <img src="Screenshots/aye.png" width="220"/>
  <img src="Screenshots/data.png" width="220"/>
</p>

## Project Structure

```bash
lib/
├── core/
│   ├── theme/
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── cubit/
│   │   ├── data/
│   │   └── ui/
│   └── welcome/
└── generated/