import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
  }) : super(key: key);
  final String icon;
  final String title;
  final Widget route;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute().navigate(context: context, route: route),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 20, 8),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 30,
              color: ColorManager.black,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: getBoldStyle(size: 14),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 15),
          ],
        ),
      ),
    );
  }
}
