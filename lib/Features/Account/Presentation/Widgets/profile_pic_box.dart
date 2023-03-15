import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Utilities/size_config.dart';
import '../ViewLogic/users_vl.dart';

class ChangeProfilePicture extends StatelessWidget {
  const ChangeProfilePicture({
    Key? key,
    required this.profileImage,
  }) : super(key: key);
  final String? profileImage;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: ColorManager.lightGrey,
      strokeCap: StrokeCap.round,
      dashPattern: const [8, 8],
      borderType: BorderType.Circle,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight! * .15,
        child: InkWell(
          onTap: () => context.read<UsersVL>().getProfileImage(),
          child: context.read<UsersVL>().getAvatar(),
        ),
      ),
    );
  }
}
