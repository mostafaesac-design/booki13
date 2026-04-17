import 'package:bookstore/features/home/ui/home_screen.dart';
import 'package:bookstore/features/order/ui/success_order_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cart/cubit/cart_cubit.dart';
import '../../profile/cubit/order_cubit.dart';
import '../../profile/data/models/order_model.dart';

class PlaceOrderScreen extends StatefulWidget {
  final double totalPrice;

  const PlaceOrderScreen({
    super.key,
    required this.totalPrice,
  });

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedGovernorate;

  final List<String> governorates = const [
    'Cairo',
    'Giza',
    'Alexandria',
    'Dakahlia',
    'Sharqia',
    'Qalyubia',
    'Gharbia',
    'Monufia',
    'Beheira',
    'Kafr El Sheikh',
    'Fayoum',
    'Beni Suef',
    'Minya',
    'Assiut',
    'Sohag',
    'Qena',
    'Luxor',
    'Aswan',
    'Ismailia',
    'Suez',
    'Port Said',
    'Damietta',
    'North Sinai',
    'South Sinai',
    'Matrouh',
    'Red Sea',
    'New Valley',
  ];

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void submitOrder() {
    if (formKey.currentState!.validate()) {
      final order = OrderModel(
        orderNumber: DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        address: addressController.text.trim(),
        phone: phoneController.text.trim(),
        governorate: selectedGovernorate ?? '',
        date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        totalPrice: widget.totalPrice,
      );

      context.read<OrderCubit>().addOrder(order);
      context.read<CartCubit>().clearCart();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SuccessOrderScreen(),
        ),
      );
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
      backgroundColor: const Color(0xffF9F5FA),
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
                          "Don't worry! It occurs. Please enter the email address linked with your account.",
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your full name';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 14.h),

                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: buildInputDecoration('Phone'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your phone';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 14.h),

                        DropdownButtonFormField<String>(
                          value: selectedGovernorate,
                          decoration: buildInputDecoration('Governorate'),
                          items: governorates.map((gov) {
                            return DropdownMenuItem<String>(
                              value: gov,
                              child: Text(gov),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGovernorate = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select governorate';
                            }
                            return null;
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
                    onPressed: submitOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffC7A84B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      'Submit Order',
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