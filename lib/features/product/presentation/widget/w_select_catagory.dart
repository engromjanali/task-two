import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_two/core/extensions/ex_build_context.dart';
import 'package:task_two/core/extensions/ex_padding.dart';
import 'package:task_two/core/widgets/w_dialog.dart';
import 'package:task_two/core/widgets/w_text_field.dart';
import 'package:task_two/features/product/data/model/m_product.dart';

Future<PCategory?> openSearchDialog({
  required BuildContext context,
  required List<PCategory> items,
  required String label,
}) async {
  List<PCategory> tempList = items;
  TextEditingController searchController = TextEditingController();

  return await WDialog.showCustom(
    context: context,
    children: [
      StatefulBuilder(
        builder: (context, setDialogState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select ${label}', style: context.textTheme?.titleMedium),
              WTextField(
                controller: searchController,
                hintText: "Search...",
                onChanged: (val) {
                  setDialogState(() {
                    tempList = items
                        .where(
                          (e) =>
                              e.name.toLowerCase().contains(val.toLowerCase()),
                        )
                        .toList();
                  });
                },
              ).pB(),
              SizedBox(
                width: double.maxFinite,
                height: 200.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: tempList.length,
                  itemBuilder: (_, index) {
                    final item = tempList[index];
                    return ListTile(
                      title: Text(item.name, overflow: TextOverflow.ellipsis),
                      onTap: () => Navigator.pop(context, item),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    ],
  );
}
