import 'package:task_two/features/product/presentation/view/s_product.dart';
import 'package:task_two/gen/assets.gen.dart';
import 'm_nav_bar_item.dart';

List<MNavBarItem> homeNevItem = [
  MNavBarItem(
    title: "Product",
    unSelectedIcon: Assets.icons.taskChecklist,
    icon: Assets.icons.taskChecklist,
    child: SProduct(),
  ),
  MNavBarItem(
    title: "Pending",
    unSelectedIcon: Assets.icons.stopwatch,
    icon: Assets.icons.stopwatch,
    child: SProduct(),
  ),
  MNavBarItem(
    title: "Profile",
    unSelectedIcon: Assets.icons.profile,
    icon: Assets.icons.profile,
    child: SProduct(),
  ),
];
