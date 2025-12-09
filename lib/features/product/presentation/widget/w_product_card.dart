import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_two/core/constants/default_values.dart';
import 'package:task_two/core/constants/dimension_theme.dart';
import 'package:task_two/core/extensions/ex_build_context.dart';
import 'package:task_two/core/extensions/ex_expanded.dart';
import 'package:task_two/core/extensions/ex_padding.dart';
import 'package:task_two/core/functions/f_snackbar.dart';
import 'package:task_two/core/widgets/image/m_image_payload.dart';
import 'package:task_two/core/widgets/image/w_image.dart';
import 'package:task_two/features/product/data/model/m_product.dart';
import 'package:task_two/features/product/presentation/widget/w_card_elevated_button.dart';

class WPCard extends StatelessWidget {
  MProduct mProduct;
  WPCard({super.key, required this.mProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      // width: 170.w,
      decoration: BoxDecoration(
        color: context.backgroundColor,
        // color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: (context.primaryTextColor ?? Colors.black).withAlpha(50),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(PTheme.borderRadius),
      ),
      padding: EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(PTheme.borderRadius),
        child: Column(
          children: [
            GestureDetector(
              // behavior: HitTestBehavior.translucent,
              child: Column(
                children: [
                  SizedBox.expand(
                    child: WImage(
                      mProduct.image,
                      payload: MImagePayload(fit: BoxFit.fill),
                    ),
                  ).expd(),
                  SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        Text(
                          mProduct.title ?? PDefaultValues.noName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2, // Let it use available space
                          style: context.textTheme?.titleSmall?.copyWith(
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.left,
                        ).expd(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$ ${mProduct.price}",
                              style: context.textTheme?.titleSmall,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20.w,
                                ),
                                Text(
                                  "${mProduct.rating?.rate ?? 0} (${mProduct.rating?.count ?? 0})",
                                  style: context.textTheme?.titleMedium
                                      ?.copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ).pAll(value: 5),
                  ),
                ],
              ),
            ).expd(),
            WCElevatedButton(
              onTap: () {
                showSnackBar("Saved To Card!");
              },
              label: "Buy Now",
              size: Size(double.infinity, 32.h),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(PTheme.borderRadius),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
