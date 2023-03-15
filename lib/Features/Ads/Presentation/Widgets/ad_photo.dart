import 'package:agriunion/App/constants/values.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/utils.dart';
import '../../../Markets/Presentation/Widgets/negotiatable_container.dart';

class AdPhoto extends StatelessWidget {
  const AdPhoto({
    required this.image,
    Key? key,
    required this.negotiable,
  }) : super(key: key);
  final String? image;
  final bool? negotiable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: SizeConfig.screenHeight! * .15,
          width: SizeConfig.screenWidth! * .35,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: radius8,
          ),
          child: image != null
              ? Image.network(image!, fit: BoxFit.cover)
              : Image.asset(AppImages.logo),
        ),
        Container(
          height: SizeConfig.screenHeight! * .15,
          width: SizeConfig.screenWidth! * .35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.7),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [.0, .2])),
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  Utils.slashFormat(DateTime.now()),
                  style: getRegularStyle(fontColor: Colors.white, fontSize: 10),
                ),
              ),
              negotiable! ? const NegotiatableContainer() : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
