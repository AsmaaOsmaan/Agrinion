import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/Features/Intro/Domain/Model/on_boarding_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../App/constants/keys.dart';
import '../../../Authentication/Presentation/Screens/auth_screen.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitialPage());
  Color color = onBoardingScreens[0].color;
  final PageController controller = PageController();

  nextPage(BuildContext context, int index) {
    color = onBoardingScreens[index].color;
    emit(OnBoardingNextPage());
  }

  void saveOnBoardingAndNavigate(BuildContext context) {
    CachHelper.saveData(key: kDontShowOnBoarding, value: true);
    AppRoute().navigate(context: context, route: const AuthScreen());
  }
}

abstract class OnBoardingState {}

class OnBoardingInitialPage extends OnBoardingState {}

class OnBoardingNextPage extends OnBoardingState {}
