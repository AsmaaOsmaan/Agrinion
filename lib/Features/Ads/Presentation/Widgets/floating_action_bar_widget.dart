import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/Features/Ads/Presentation/Screen/my_old_ads.dart';
import 'package:agriunion/Features/Ads/Presentation/Widgets/stepper.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingAB extends StatelessWidget {
  const FloatingAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      useRotationAnimation: true,
      direction: context.locale == const Locale('en', 'US')
          ? SpeedDialDirection.right
          : SpeedDialDirection.left,
      icon: Icons.add,
      activeIcon: Icons.close,
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.white,
      activeForegroundColor: Colors.black,
      visible: true,
      closeManually: false,
      backgroundColor: ColorManager.primary,
      overlayColor: Colors.black,
      elevation: 8.0,
      shape: const CircleBorder(),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.add),
          backgroundColor: ColorManager.lightPrimary,
          foregroundColor: Colors.white,
          label: tr(LocaleKeys.add_ad),
          onTap: () {
            AppRoute().navigate(
              context: context,
              route: const StepperDemo(),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.copy_all),
          backgroundColor: ColorManager.secondary,
          foregroundColor: Colors.white,
          label: tr(LocaleKeys.copy_ad),
          onTap: () {
            AppRoute().navigate(
              context: context,
              route: const MyOldAds(),
            );
          },
        ),
      ],
    );
  }
}
