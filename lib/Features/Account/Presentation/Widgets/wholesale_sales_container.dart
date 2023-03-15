import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/size_config.dart';

class WholeSaleSalesContainer extends StatelessWidget {
  const WholeSaleSalesContainer({
    Key? key,
    required this.title,
    required this.color,
    required this.routeTo,
    this.onTap,
  }) : super(key: key);
  final String title;
  final Color color;
  final Widget routeTo;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTap ?? () {};
        AppRoute().navigate(context: context, route: routeTo);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        width: SizeConfig.screenWidth! * .4,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: getBoldStyle(
              size: 14,
              fontColor: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}
