import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:power_state/power_state.dart';
import 'package:task_two/core/extensions/ex_build_context.dart';
import 'package:task_two/core/extensions/ex_expanded.dart';
import 'package:task_two/core/extensions/ex_padding.dart';
import 'package:task_two/core/functions/f_call_back.dart';
import 'package:task_two/core/functions/f_printer.dart';
import 'package:task_two/core/widgets/drop_down/w_drop_down.dart';
import 'package:task_two/core/widgets/load_and_error/models/view_state_model.dart';
import 'package:task_two/core/widgets/w_app_shimmer.dart';
import 'package:task_two/core/widgets/w_dialog.dart';
import 'package:task_two/core/widgets/w_text_field.dart';
import 'package:task_two/features/product/data/datasource/product_datasource_impl.dart';
import 'package:task_two/features/product/data/model/m_filter.dart';
import 'package:task_two/features/product/data/model/m_product.dart';
import 'package:task_two/features/product/data/repository/product_repository_impl.dart';
import 'package:task_two/features/product/presentation/controller/c_product.dart';
import 'package:task_two/features/product/presentation/widget/w_product_card.dart';
import 'package:task_two/features/product/presentation/widget/w_select_catagory.dart';

class SProduct extends StatefulWidget {
  const SProduct({super.key});

  @override
  State<SProduct> createState() => _SProductState();
}

class _SProductState extends State<SProduct> {
  List<MProduct> items = [];
  PCategory? seectedCatagory;
  CProduct cProduct = PowerVault.put(
    CProduct(ProductRepositoryImpl(ProductDataSourceImpl())),
  );
  ValueNotifier<MFilter> filterNotifyer = ValueNotifier(MFilter());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    callBackFunction(() {
      cProduct.fetchProduct().then((products) {
        items.addAll(products ?? []);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: PowerBuilder<CProduct>(
        builder: (cProduct) {
          return ValueListenableBuilder(
            valueListenable: filterNotifyer,
            builder: (context, filter, child) {
              printer("rebuild notifyer");
              items = filterItemList(cProduct.productList, filter);
              if (cProduct.viewState == ViewState.loading && items.isEmpty) {
                return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => WAppsShimmer(),
                );
              }
              return Column(
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: (val) {
                      filterNotifyer.value = MFilter(
                        title: val,
                        catagory: seectedCatagory,
                      );
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search_sharp),
                      hintText: "Search Product Here",
                      suffixIcon: IconButton(
                        onPressed: () async {
                          seectedCatagory = await openSearchDialog(
                            context: context,
                            items: PCategory.values,
                            label: "Caragory",
                          );
                          filterNotifyer.value = MFilter(
                            title: filter.title,
                            catagory: seectedCatagory,
                          );
                        },
                        icon: Icon(Icons.tune_rounded),
                      ),
                    ),
                  ).pB(),

                  RefreshIndicator(
                    onRefresh: () async {
                      printer("refreshed");
                      cProduct.productList.clear();
                      cProduct.update();
                      await cProduct.fetchProduct();
                    },
                    color: context.textTheme?.titleMedium?.color,
                    backgroundColor: context.fillColor,
                    child: GridView.builder(
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14.h,
                        crossAxisSpacing: 50.w,
                        mainAxisExtent: 220.h,
                      ),
                      itemBuilder: (context, index) {
                        MProduct mProduct = items[index];
                        return WPCard(mProduct: mProduct);
                      },
                    ),
                  ).expd(),
                ],
              ).pAll();
            },
          );
        },
      ),
    );
  }
}

List<MProduct> filterItemList(List<MProduct> input, MFilter mFilter) {
  List<MProduct> res;

  res = input
      .where(
        (o) => (o.title ?? "").toLowerCase().contains(
          mFilter.title ?? "".toLowerCase(),
        ),
      )
      .toList();

  if (mFilter.catagory != null) {
    res = res.where((o) => (o.category == mFilter.catagory)).toList();
  }

  return res;
}
