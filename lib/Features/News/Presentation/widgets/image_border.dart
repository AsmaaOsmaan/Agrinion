import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/constants/distances.dart';
import '../ViewLogic/news_vl.dart';

class ImageBorder extends StatelessWidget {
  const ImageBorder({
    Key? key,
    required this.content,
    required this.vl,
  }) : super(key: key);
  final Widget content;
  final NewsVL vl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(paddingDistance),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * .15,
      child: DottedBorder(
        color: ColorManager.lightGrey,
        strokeCap: StrokeCap.round,
        dashPattern: const [8, 8],
        borderType: BorderType.Rect,
        child: InkWell(
          onTap: () => vl.getNewsImage(),
          child: content,
        ),
      ),
    );
  }
}
