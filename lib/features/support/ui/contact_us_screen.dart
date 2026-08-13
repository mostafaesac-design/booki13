import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/features/support/cubit/support_cubit.dart';
import 'package:bookstore/features/support/cubit/support_state.dart';
import 'package:bookstore/features/support/ui/widgets/support_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: const BorderSide(color: AppColors.border),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SupportScaffold(
      title: 'contact_us'.tr(),
      child: BlocBuilder<SupportCubit, SupportState>(
        builder: (context, state) => SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'contact_intro'.tr(),
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: nameController,
                decoration: _decoration('full_name'.tr()),
              ),
              SizedBox(height: 14.h),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration('email'.tr()),
              ),
              SizedBox(height: 14.h),
              TextField(
                controller: messageController,
                minLines: 5,
                maxLines: 7,
                decoration: _decoration('message'.tr()),
              ),
              if (state.validationMessage != null) ...[
                SizedBox(height: 10.h),
                Text(
                  state.validationMessage!.tr(),
                  style: const TextStyle(color: AppColors.error),
                ),
              ],
              SizedBox(height: 22.h),
              AppButton(
                text: 'send_message'.tr(),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final sent = await context.read<SupportCubit>().sendMessage(
                    name: nameController.text,
                    email: emailController.text,
                    message: messageController.text,
                  );
                  if (sent && context.mounted) {
                    nameController.clear();
                    emailController.clear();
                    messageController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Message sent successfully.'),
                      ),
                    );
                  } else if (context.mounted &&
                      context.read<SupportCubit>().state.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          context.read<SupportCubit>().state.error!,
                        ),
                      ),
                    );
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
