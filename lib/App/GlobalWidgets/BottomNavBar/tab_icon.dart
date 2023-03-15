import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:flutter/material.dart';

import '../../../Features/Home/Presentation/Widgets/home_imports.dart';
import '../../../Features/cart/Presention/widgets/cart_icon.dart';

class TabIcon extends StatelessWidget {
  final HomeData homeData = HomeData();
  final int? index;
  final bool? active;
  TabIcon({Key? key, this.index, this.active = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color color = active! ? ColorManager.black : ColorManager.grey;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: active! ? ColorManager.black : Colors.transparent,
          height: 4,
          width: 50,
        ),
        index! == 2
            ? CartWidget(color: color)
            : Image.asset(
                homeData.tabs[index!].iconData,
                width: 22,
                height: 22,
                color: color,
              ),
        Text(
          homeData.tabs[index!].title,
          style: getBoldStyle(size: 10, fontColor: color),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
