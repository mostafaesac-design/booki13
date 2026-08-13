import 'dart:io';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bookstore/core/widgets/app_page_header.dart';
import 'package:bookstore/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';

import '../cubit/profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  String imagePath = '';

  ImageProvider<Object>? get profileImage {
    if (imagePath.isEmpty) return null;
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return NetworkImage(imagePath);
    }
    return FileImage(File(imagePath));
  }

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileCubit>().state.profile;
    nameController = TextEditingController(text: profile.name);
    phoneController = TextEditingController(text: profile.phone);
    addressController = TextEditingController(text: profile.address);
    imagePath = profile.imagePath;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (!mounted || file == null) return;

    setState(() {
      imagePath = file.path;
    });
  }

  InputDecoration buildInput(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            children: [
              AppPageHeader(title: 'edit_profile'.tr()),
              SizedBox(height: 28.h),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 58.r,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: profileImage,
                    child: imagePath.isEmpty
                        ? Icon(Icons.person, size: 50.sp, color: Colors.white)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 16.r,
                        backgroundColor: AppColors.primaryAction,
                        child: Icon(
                          Icons.camera_alt,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 26.h),
              TextField(
                controller: nameController,
                decoration: buildInput('Full Name'),
              ),
              SizedBox(height: 14.h),
              TextField(
                controller: phoneController,
                decoration: buildInput('Phone'),
              ),
              SizedBox(height: 14.h),
              TextField(
                controller: addressController,
                decoration: buildInput('Address'),
              ),
              const Spacer(),
              AppButton(
                text: 'update_profile'.tr(),
                onTap: () async {
                  final updated = await context
                      .read<ProfileCubit>()
                      .updateProfile(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        address: addressController.text.trim(),
                        imagePath: imagePath,
                      );

                  if (!context.mounted) return;

                  if (updated) {
                    Navigator.pop(context);
                  } else {
                    final error =
                        context.read<ProfileCubit>().state.error ??
                        'Update failed.';
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(error)));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
