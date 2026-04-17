# 📚 Bookia

**Bookia** is a Flutter bookstore application that provides a smooth and modern user experience for browsing books, managing favorites, adding items to cart, updating profile details, and handling authentication flows.

---

## ✨ Features

- 🌍 Multi-language support (English / Arabic)
- 🔐 Authentication system
    - Login
    - Register
    - Forgot Password
    - OTP Verification
    - Create New Password
    - Password Changed
- 🏠 Home screen with featured books
- 📖 Product details screen
- ❤️ Wishlist screen
- 🛒 Cart screen
- 👤 Profile screen
- ✏️ Edit profile screen
- 🔒 Change password screen
- 📦 My orders screen
- 📱 Responsive UI using `flutter_screenutil`

## 📸 Screenshots

<p align="center">
  <img src="Screenshots/home_screen.png" width="200"/>
  <img src="Screenshots/product_details_screen.png" width="200"/>
  <img src="Screenshots/wishlist_screen.png" width="200"/>
</p>

<p align="center">
  <img src="Screenshots/cart_screen.png" width="200"/>
  <img src="Screenshots/profile_screen.png" width="200"/>
  <img src="Screenshots/edit_profile_screen.png" width="200"/>
</p>

<p align="center">
  <img src="Screenshots/change_password_screen.png" width="200"/>
  <img src="Screenshots/my_orders_screen.png" width="200"/>
  <img src="Screenshots/login.png" width="200"/>
</p>

<p align="center">
  <img src="Screenshots/register.png" width="200"/>
  <img src="Screenshots/forgot_password.png" width="200"/>
  <img src="Screenshots/otp_verification.png" width="200"/>
</p>

<p align="center">
  <img src="Screenshots/create_new_password.png" width="200"/>
  <img src="Screenshots/password_changed.png" width="200"/>
  <img src="Screenshots/welcome.png" width="200"/>
</p>

<p align="center">
  <img src="Screenshots/welcome_ar.png" width="200"/>
</p>

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **Cubit / Bloc**
- **Dio**
- **Easy Localization**
- **Shared Preferences**
- **Image Picker**

---

## 📂 Project Structure

```bash
lib
├── core
├── features
│   ├── auth
│   ├── home
│   ├── wishlist
│   ├── cart
│   ├── profile
│   └── order
└── main.dart