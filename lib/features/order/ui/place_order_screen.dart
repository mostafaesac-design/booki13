import 'package:bookstore/features/order/data/models/governorate_model.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/features/order/ui/success_order_screen.dart';
import 'package:bookstore/features/profile/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cart/cubit/cart_cubit.dart';
import '../../profile/cubit/order_cubit.dart';

class PlaceOrderScreen extends StatefulWidget {
  final double totalPrice;

  const PlaceOrderScreen({super.key, required this.totalPrice});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GovernorateModel? selectedGovernorate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final orderCubit = context.read<OrderCubit>();
      if (orderCubit.state.governorates.isEmpty) {
        orderCubit.getGovernorates();
      }
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> submitOrder() async {
    if (!formKey.currentState!.validate() || selectedGovernorate == null) {
      return;
    }
    final orderId = await context.read<OrderCubit>().placeOrder(
      governorateId: selectedGovernorate!.id,
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      phone: phoneController.text.trim(),
    );
    if (!mounted) return;
    if (orderId != null && orderId > 0) {
      await context.read<CartCubit>().loadCart();
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SuccessOrderScreen(orderId: orderId)),
      );
    } else {
      final message =
          context.read<OrderCubit>().state.ordersError ??
          'Could not place the order.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  InputDecoration buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: Colors.grey.shade400),
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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Place Your Order',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Enter your delivery details to complete your order.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.blueGrey,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: 22.h),
                        TextFormField(
                          controller: fullNameController,
                          decoration: buildInputDecoration('Full Name'),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? 'Enter your full name'
                              : null,
                        ),
                        SizedBox(height: 14.h),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: buildInputDecoration('Email'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your email';
                            }

                            if (!value.contains('@')) {
                              return 'Enter valid email';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 14.h),
                        TextFormField(
                          controller: addressController,
                          decoration: buildInputDecoration('Address'),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? 'Enter your address'
                              : null,
                        ),
                        SizedBox(height: 14.h),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: buildInputDecoration('Phone'),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? 'Enter your phone'
                              : null,
                        ),
                        SizedBox(height: 14.h),
                        BlocBuilder<OrderCubit, OrderState>(
                          buildWhen: (previous, current) =>
                              previous.governorates != current.governorates ||
                              previous.isLoadingGovernorates !=
                                  current.isLoadingGovernorates ||
                              previous.governoratesError !=
                                  current.governoratesError,
                          builder: (context, state) {
                            if (state.isLoadingGovernorates &&
                                state.governorates.isEmpty) {
                              return Container(
                                height: 56.h,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text('Loading governorates...'),
                                  ],
                                ),
                              );
                            }
                            if (state.governoratesError != null &&
                                state.governorates.isEmpty) {
                              return Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color: Colors.red.shade200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Failed to load governorates',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => context
                                          .read<OrderCubit>()
                                          .getGovernorates(),
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return DropdownButtonFormField<GovernorateModel>(
                              initialValue: selectedGovernorate,
                              isExpanded: true,
                              decoration: buildInputDecoration('Governorate'),
                              items: state.governorates
                                  .map(
                                    (governorate) =>
                                        DropdownMenuItem<GovernorateModel>(
                                          value: governorate,
                                          child: Text(governorate.name),
                                        ),
                                  )
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => selectedGovernorate = value),
                              validator: (value) =>
                                  value == null ? 'Select governorate' : null,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${widget.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: context.watch<OrderCubit>().state.isPlacingOrder
                        ? null
                        : submitOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAction,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      context.watch<OrderCubit>().state.isPlacingOrder
                          ? 'Submitting...'
                          : 'Submit Order',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
