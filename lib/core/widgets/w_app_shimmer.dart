import '/core/extensions/ex_build_context.dart';
import '/core/extensions/ex_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/widgets/w_container.dart';
import '/core/widgets/w_shimmer.dart';

class WAppsShimmer extends StatelessWidget {
  const WAppsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        2,
        (index) => Column(
          children: [
            // Left shimmer image
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 150.h,
                  width: 180.w,
                  color: Colors.grey.shade300,
                ),
              ),
            ).pB(),

            // Text shimmer blocks
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 12.h,
                    width: 180.w,
                    color: Colors.grey.shade300,
                  ),
                ).pB(value: 6),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 10.h,
                    width: 180.w,
                    color: Colors.grey.shade300,
                  ),
                ).pB(),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                      color: Colors.grey.shade300,
                    ),
                    height: 30.h,
                    width: 180.w,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).pAll();
  }
}
