import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';
class CustomNetworkImage extends StatelessWidget {
  final String urlImage;
  final double height;
  final double width;
  const CustomNetworkImage({super.key, required this.urlImage, this.height=280, this.width=160});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:urlImage,
      height:height ,
      width:width ,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Skeletonizer(
        enabled: true,
        child: Container(
          height: height,
          width: width,
          color: AppColors.hint,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
