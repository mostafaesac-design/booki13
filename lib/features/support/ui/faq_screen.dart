import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/features/support/cubit/support_cubit.dart';
import 'package:bookstore/features/support/cubit/support_state.dart';
import 'package:bookstore/features/support/ui/widgets/support_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SupportScaffold(
      title: 'faq'.tr(),
      child: BlocBuilder<SupportCubit, SupportState>(
        builder: (context, state) {
          if (state.isLoadingFaqs && state.faqs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.faqs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.error!, textAlign: TextAlign.center),
                  TextButton(
                    onPressed: () {
                      context.read<SupportCubit>().loadFaqs();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.faqs.isEmpty) {
            return const Center(child: Text('No FAQs available.'));
          }
          if (state.faqs.isEmpty) {
            return const Center(child: Text('No FAQs available.'));
          }
          return ListView.separated(
            padding: EdgeInsets.only(bottom: 24.h),
            itemCount: state.faqs.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final expanded = state.expandedFaqIndex == index;
              return InkWell(
                onTap: () => context.read<SupportCubit>().toggleFaq(index),
                borderRadius: BorderRadius.circular(14.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              state.faqs[index].question,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(
                            expanded ? Icons.remove : Icons.add,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      if (expanded) ...[
                        SizedBox(height: 12.h),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            state.faqs[index].answer,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
