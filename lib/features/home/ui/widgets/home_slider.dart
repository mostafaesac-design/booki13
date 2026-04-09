import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int activeIndex=0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    if(state is SliderLoadingState){
      return CircularProgressIndicator();
    }else if(state is SliderSuccessState){
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 130.0.h,
                autoPlay: true,
                onPageChanged: (index,r){
                  setState(() {
                    activeIndex=index;
                  });
                },
                viewportFraction: 1
            ),
            items: state.sliders?.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.network(
                          i.image ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 10.h,),
          AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: state.sliders?.length??0,
            effect: ExpandingDotsEffect(
                dotHeight: 10,
                activeDotColor: AppColors.mainColor
            ),
          )
        ],
      );
    }else{
      return Text("Error");
    }
  },
);
  }
}




















