import 'dart:io';

import 'package:bookstore/core/networking/api_result.dart';
import 'package:bookstore/core/routes/routes.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/features/profile/cubit/profile_cubit.dart';
import 'package:bookstore/features/profile/cubit/profile_state.dart';
import 'package:bookstore/features/profile/ui/widgets/profile_menu_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  ImageProvider<Object>? _profileImage(String path) {
    if (path.isEmpty) return null;
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return NetworkImage(path);
    }
    return FileImage(File(path));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: context.read<ProfileCubit>().loadProfile,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
                children: [
                  Row(
                    children: [
                      SizedBox(width: 42.w),
                      Expanded(
                        child: Text(
                          'profile'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 42.w,
                        child: IconButton(
                          tooltip: 'notifications'.tr(),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            Routes.notificationsScreen,
                          ),
                          icon: const Icon(Icons.notifications_none_rounded),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 26.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 34.r,
                        backgroundColor: AppColors.disabled,
                        backgroundImage: _profileImage(profile.imagePath),
                        child: profile.imagePath.isEmpty
                            ? Icon(
                          Icons.person,
                          size: 36.sp,
                          color: AppColors.surface,
                        )
                            : null,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.name,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              profile.email,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  ProfileMenuItem(
                    title: 'my_orders'.tr(),
                    icon: Icons.receipt_long_outlined,
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.myOrdersScreen),
                  ),
                  ProfileMenuItem(
                    title: 'edit_profile'.tr(),
                    icon: Icons.person_outline_rounded,
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.editProfileScreen),
                  ),
                  ProfileMenuItem(
                    title: 'change_password'.tr(),
                    icon: Icons.lock_outline_rounded,
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.changePasswordScreen,
                    ),
                  ),
                  ProfileMenuItem(
                    title: 'faq'.tr(),
                    icon: Icons.help_outline_rounded,
                    onTap: () => Navigator.pushNamed(context, Routes.faqScreen),
                  ),
                  ProfileMenuItem(
                    title: 'contact_us'.tr(),
                    icon: Icons.headset_mic_outlined,
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.contactUsScreen),
                  ),
                  ProfileMenuItem(
                    title: 'privacy_terms'.tr(),
                    icon: Icons.privacy_tip_outlined,
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.privacyTermsScreen),
                  ),
                  ProfileMenuItem(
                    title: 'Delete account',
                    icon: Icons.delete_outline_rounded,
                    onTap: () async {
                      final passwordController = TextEditingController();
                      final password = await showDialog<String>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Delete account?'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'This action permanently deletes your account.',
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Current password',
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(
                                dialogContext,
                                passwordController.text,
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      passwordController.dispose();
                      if (password == null ||
                          password.isEmpty ||
                          !context.mounted) {
                        return;
                      }
                      final deleted = await context
                          .read<ProfileCubit>()
                          .deleteAccount(password);
                      if (!context.mounted) return;
                      if (deleted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.loginScreen,
                              (_) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context.read<ProfileCubit>().state.error ??
                                  'Could not delete account.',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  ProfileMenuItem(
                    title: 'logout'.tr(),
                    icon: Icons.logout_rounded,
                    onTap: () async {
                      if (state.isLoading) return;

                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: Text('logout'.tr()),
                          content: const Text(
                            'Are you sure you want to log out?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, true),
                              child: Text('logout'.tr()),
                            ),
                          ],
                        ),
                      );

                      if (shouldLogout != true || !context.mounted) return;

                      final result = await context
                          .read<ProfileCubit>()
                          .logout();
                      if (!context.mounted) return;
                      if (result is ApiSuccess<bool>) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.loginScreen,
                              (_) => false,
                        );
                      } else if (result is ApiFailure<bool>) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          SnackBar(content: Text(result.message)),
                        );
                      }
                    },
                  ),
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
