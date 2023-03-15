import 'package:flutter/material.dart';

import '../Resources/color_manager.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    Key? key,
    this.margin = const EdgeInsets.all(20),
    required this.tabBar,
  }) : super(key: key);
  final EdgeInsets? margin;
  final TabBar tabBar;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin!,
      height: 40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: tabBar,
    );
  }
}
