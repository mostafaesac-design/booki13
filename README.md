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


## Screenshots

### Home
![Home Screen](Screenshots/home_screen.png)

### Wishlist
![Wishlist Screen](Screenshots/wishlist_screen.png)

### Cart
![Cart Screen](Screenshots/cart_screen.png)

### Product Details
![Product Details Screen](Screenshots/product_details_screen.png)

### Profile
![Profile Screen](Screenshots/profile_screen.png)

### Edit Profile
![Edit Profile Screen](Screenshots/edit_profile_screen.png)

### Change Password
![Change Password Screen](Screenshots/change_password_screen.png)
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