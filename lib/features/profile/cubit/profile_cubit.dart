import 'package:bookstore/core/helper/app_constants.dart';
import 'package:bookstore/core/networking/api_error_handler.dart';
import 'package:bookstore/core/networking/api_result.dart';
import 'package:bookstore/features/profile/data/models/profile_model.dart';
import 'package:bookstore/features/profile/data/repo/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({ProfileRepo? profileRepo})
    : _profileRepo = profileRepo ?? ProfileRepo(),
      super(
        const ProfileState(
          profile: ProfileModel(
            name: 'Bookstore User',
            email: '',
            phone: '',
            address: '',
            imagePath: '',
          ),
        ),
      );

  final ProfileRepo _profileRepo;

  Future<void> loadProfile() async {
    if (AppConstants.token?.isEmpty ?? true) return;
    emit(state.copyWith(isLoading: true, clearMessages: true));
    try {
      emit(ProfileState(profile: await _profileRepo.getProfile()));
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String phone,
    required String address,
    required String imagePath,
  }) async {
    emit(state.copyWith(isLoading: true, clearMessages: true));
    try {
      final profile = await _profileRepo.updateProfile(
        name: name,
        phone: phone,
        address: address,
        imagePath: imagePath,
      );
      emit(
        ProfileState(
          profile: profile,
          successMessage: 'Profile updated successfully.',
        ),
      );
      return true;
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
      return false;
    }
  }

  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (currentPassword.isEmpty ||
        newPassword.length < 8 ||
        newPassword != confirmPassword) {
      emit(state.copyWith(error: 'Please check the entered passwords.'));
      return false;
    }
    emit(state.copyWith(isLoading: true, clearMessages: true));
    try {
      await _profileRepo.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'Password updated successfully.',
        ),
      );
      return true;
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
      return false;
    }
  }

  Future<ApiResult<bool>> logout() async {
    emit(state.copyWith(isLoading: true, clearMessages: true));
    final result = await _profileRepo.logout();
    if (result is ApiSuccess<bool>) await _clearSession();
    emit(state.copyWith(isLoading: false));
    return result;
  }

  Future<bool> deleteAccount(String currentPassword) async {
    if (currentPassword.isEmpty) return false;
    emit(state.copyWith(isLoading: true, clearMessages: true));
    try {
      await _profileRepo.deleteAccount(currentPassword);
      await _clearSession();
      emit(state.copyWith(isLoading: false));
      return true;
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
      return false;
    }
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    AppConstants.token = null;
  }
}
