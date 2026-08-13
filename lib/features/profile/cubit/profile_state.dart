import 'package:equatable/equatable.dart';
import 'package:bookstore/features/profile/data/models/profile_model.dart';

class ProfileState extends Equatable {
  final ProfileModel profile;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const ProfileState({
    required this.profile,
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
    String? error,
    String? successMessage,
    bool clearMessages = false,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: clearMessages ? null : error ?? this.error,
      successMessage: clearMessages
          ? null
          : successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [profile, isLoading, error, successMessage];
}
