import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookstore/features/profile/data/models/profile_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : super(
    const ProfileState(
      profile: ProfileModel(
        name: 'Mostafa',
        email: 'mostafa@gmail.com',
        phone: '',
        address: '',
        imagePath: '',
      ),
    ),
  ) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('profile_name') ?? 'Mostafa';
    final email = prefs.getString('profile_email') ?? 'mostafa@gmail.com';
    final phone = prefs.getString('profile_phone') ?? '';
    final address = prefs.getString('profile_address') ?? '';
    final imagePath = prefs.getString('profile_image') ?? '';

    emit(
      state.copyWith(
        profile: ProfileModel(
          name: name,
          email: email,
          phone: phone,
          address: address,
          imagePath: imagePath,
        ),
      ),
    );
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
    required String imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('profile_name', name);
    await prefs.setString('profile_phone', phone);
    await prefs.setString('profile_address', address);
    await prefs.setString('profile_image', imagePath);

    emit(
      state.copyWith(
        profile: state.profile.copyWith(
          name: name,
          phone: phone,
          address: address,
          imagePath: imagePath,
        ),
      ),
    );
  }

  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final savedPassword = prefs.getString('saved_password') ?? '';

    if (currentPassword != savedPassword) {
      return false;
    }

    if (newPassword != confirmPassword) {
      return false;
    }

    await prefs.setString('saved_password', newPassword);
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}