import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/network_image.dart';

class ZoomInImage extends StatelessWidget {
  final String image;
  const ZoomInImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,foregroundColor: Colors.white,),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Center(
        child: NetWorkImage(
          image: image,
          height: .5.sh,
          width: double.infinity,
        ),
      ),
    );
  }
}
