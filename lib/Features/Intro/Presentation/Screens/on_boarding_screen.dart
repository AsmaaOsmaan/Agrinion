import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/Features/Intro/Domain/Model/on_boarding_model.dart';
import 'package:agriunion/Features/Intro/Presentation/BloC/on_boarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../App/Utilities/size_config.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late OnBoardingCubit onBoardingCubit;
  @override
  void initState() {
    onBoardingCubit = context.read<OnBoardingCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: ((context, state) => Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [onBoardingCubit.color, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [.1, .7],
                ),
              ),
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 14,
                    child: PageView.builder(
                      reverse: true,
                      controller: onBoardingCubit.controller,
                      onPageChanged: (index) =>
                          onBoardingCubit.nextPage(context, index),
                      itemBuilder: (context, index) => Column(
                        children: [
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: onBoardingCubit.color.withOpacity(.5),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                color: onBoardingCubit.color,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                height: SizeConfig.screenHeight! * .12,
                                width: SizeConfig.screenWidth! * .5,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child:
                                    Image.asset(onBoardingScreens[index].icon),
                                padding: const EdgeInsets.all(20),
                              ),
                            ),
                          ),
                          const Spacer(flex: 2),
                          Text(
                            onBoardingScreens[index].title,
                            style: getBoldStyle(size: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              onBoardingScreens[index].subtitle,
                              textAlign: TextAlign.center,
                              style: getRegularStyle(
                                  fontColor: Colors.black, fontSize: 16),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      itemCount: onBoardingScreens.length,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () => onBoardingCubit
                                    .saveOnBoardingAndNavigate(context),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        context.watch<OnBoardingCubit>().color,
                                  ),
                                  child: const Icon(
                                    Icons.keyboard_double_arrow_right_outlined,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () => onBoardingCubit
                                      .saveOnBoardingAndNavigate(context),
                                  child: Text(
                                    "تخطي",
                                    style: TextStyle(
                                      color: context
                                          .watch<OnBoardingCubit>()
                                          .color,
                                    ),
                                  )),
                            ],
                          ),
                          SmoothPageIndicator(
                            textDirection: TextDirection.ltr,
                            controller: onBoardingCubit.controller,
                            count: onBoardingScreens.length,
                            effect: SwapEffect(
                                dotHeight: 10,
                                dotWidth: 10,
                                strokeWidth: 5,
                                dotColor: ColorManager.lightGrey,
                                activeDotColor:
                                    context.watch<OnBoardingCubit>().color),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
