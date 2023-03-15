import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/utils.dart';
import '../../../../App/constants/values.dart';

class StoreItem extends StatelessWidget {
  const StoreItem({
    Key? key,
    this.inList = true,
  }) : super(key: key);
  final bool inList;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: inList ? Border.all(color: ColorManager.lightGrey) : null,
        color: inList
            ? ColorManager.lightGrey1
            : ColorManager.yellow.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("إسم المخزن", style: getBoldStyle()),
              Row(
                children: [
                  const Icon(Icons.location_pin),
                  Text(
                    "الرياض - حي العزيزية",
                    style: getBoldStyle(
                      fontColor: ColorManager.grey,
                      size: 12,
                    ),
                  ),
                ],
              ),
              inList
                  ? Row(
                      children: [
                        const SizedBox(width: 25),
                        Text(
                          "أنشئ في: ${Utils.dateformatedHeader(DateTime.now())}",
                          style: getMediumStyle(),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
          Container(
            height: SizeConfig.screenHeight! * .1,
            width: SizeConfig.screenWidth! * .2,
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.lightGrey),
              borderRadius: radius8,
            ),
          ),
        ],
      ),
    );
  }
}
