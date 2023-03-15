import 'package:flutter/material.dart';

import '../../../../../App/Resources/color_manager.dart';
import '../../../../../App/Resources/text_themes.dart';
import '../../../../../App/Utilities/size_config.dart';

class AddStoryCard extends StatelessWidget {
  final String title;
  final Widget widget;
  final Function? onTap;

  const AddStoryCard({
    Key? key,
    required this.title,
    required this.widget,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: SizedBox(
        width: SizeConfig.screenHeight! * .18,
        height: SizeConfig.screenHeight! * .18,
        child: Card(
          color: ColorManager.lightGrey1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widget,
              Text(
                title,
                style: getBoldStyle(fontColor: ColorManager.black, size: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
