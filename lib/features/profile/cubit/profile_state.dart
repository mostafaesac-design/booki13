import 'package:equatable/equatable.dart';
import 'package:bookstore/features/profile/data/models/profile_model.dart';

class ProfileState extends Equatable {
  final ProfileModel profile;
  final bool isLoading;

  const ProfileState({
    required this.profile,
    this.isLoading = false,
  });

  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [profile, isLoading];
}