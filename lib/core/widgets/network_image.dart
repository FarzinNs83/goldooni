import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/widgets/shimmer_widget.dart';

class NetWorkImage extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final String image;
  final BoxFit fit;
  const NetWorkImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        image,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.broken_image_rounded,
              size: 30.r,
              color: Colors.grey.shade600,
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return ShimmerWidget(width: width, height: height, borderRadius: borderRadius.r);
        },
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          if (frame == null) {
            return ShimmerWidget(width: width, height: height, borderRadius: borderRadius.r);
          }
          return child;
        },
      ),
    );
  }
}
