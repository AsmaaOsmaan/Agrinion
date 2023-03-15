import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/Authentication/Presentation/Screens/auth_screen.dart';
import 'package:agriunion/Features/Home/Presentation/Screens/home_screen.dart';
import 'package:agriunion/Features/Intro/Presentation/BloC/on_boarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../App/Utilities/global_notification.dart';
import '../../../../App/constants/keys.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool dontShowOnBoarding =
      CachHelper.getData(key: kDontShowOnBoarding) ?? false;
  bool remember = false;
  bool sessionValid = false;
  final GlobalNotification globalNotification = GlobalNotification.instance;

  @override
  void initState() {
    GlobalNotification.instance.setUpNotification(context);
    remember = CachHelper.getData(key: kRemember) ?? false;
    sessionValid = CachHelper.getData(key: kToken) != null;
    manageRouteAfterSplash();
    super.initState();
  }

  void manageRouteAfterSplash() {
    Future.delayed(
      const Duration(seconds: 3),
      (() {
        if (dontShowOnBoarding) {
          if (!remember) {
            AppRoute()
                .navigateAndRemove(context: context, route: const AuthScreen());
          } else {
            AppRoute()
                .navigateAndRemove(context: context, route: const HomeScreen());
          }
        } else {
          AppRoute().navigateAndRemove(
              context: context,
              route: BlocProvider(
                create: (context) => OnBoardingCubit(),
                child: const OnBoardingScreen(),
              ));
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Image.asset(
              AppImages.splash,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: LottieBuilder.asset(
              AppLottie.loading,
              height: 100,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
