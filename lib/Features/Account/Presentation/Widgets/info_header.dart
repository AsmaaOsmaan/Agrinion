import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/distances.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/Account/Presentation/ViewLogic/users_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/Resources/text_themes.dart';
import '../../../../generated/translations.g.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader({
    Key? key,
    required this.onTap,
    this.bgColor,
    required this.suffixIcon,
    this.fontColor,
  }) : super(key: key);
  final Function onTap;
  final Color? bgColor;
  final Widget suffixIcon;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: paddingDistance),
        height: SizeConfig.screenHeight! * .15,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              context.watch<UsersVL>().profile?.avatar != null
                  ? Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      height: SizeConfig.screenHeight! * .08,
                      child: Image.network(
                        context.watch<UsersVL>().profile!.avatar!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 35),
                    ),
              const SizedBox(width: paddingDistance),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.watch<UsersVL>().profile?.name ??
                          tr(LocaleKeys.username),
                      overflow: TextOverflow.ellipsis,
                      style: getBoldStyle(fontColor: fontColor ?? Colors.black),
                    ),
                    Text(
                      CachHelper.getData(key: kType),
                      style: getBoldStyle(fontColor: fontColor ?? Colors.black),
                    ),
                    Text(
                      "الرياض, المملكة العربية السعودية",
                      style:
                          getRegularStyle(fontColor: fontColor ?? Colors.black),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              suffixIcon,
            ],
          ),
        ),
      ),
    );
  }
}
