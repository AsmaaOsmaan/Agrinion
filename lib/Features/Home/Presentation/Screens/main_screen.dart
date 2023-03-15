import 'package:agriunion/Features/Notification/Presentation/Screens/notification_screen.dart';
import 'package:agriunion/Features/Stories/Presentation/Screeens/my_stories.dart';
import 'package:agriunion/Features/Stories/Presentation/Screeens/stories_screen.dart';
import 'package:agriunion/Features/Stories/Presentation/ViewLogic/story_vl.dart';
import 'package:agriunion/Features/Swalif/Presentation/Screens/swalif_posts_screen.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../App/GlobalWidgets/swaleef_screen.dart';
import '../../../../App/Resources/assets_manager.dart';
import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../PricesList/Presentation/Screens/prices_list_filter.dart';
import '../Widgets/home_imports.dart';

class MainScreen extends StatefulWidget {
  final Function(int index)? changeIndex;
  const MainScreen({
    Key? key,
    this.changeIndex,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    context.read<StoryVL>().getAllStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: SizeConfig.screenHeight! * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => AppRoute().navigate(
                    context: context, route: const NotificationScreen()),
                child: Badge(
                  position: BadgePosition.topStart(start: 0, top: 0),
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              Image.asset(
                AppImages.homeLogo,
                width: SizeConfig.screenWidth! * .4,
                alignment: Alignment.centerLeft,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        const StoriesScreen(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeContainer.square(
                      title: "أسواق الجملة",
                      height: SizeConfig.screenHeight! * .23,
                      width: SizeConfig.screenWidth! * .42,
                      onTap: () => widget.changeIndex!(1),
                      color: ColorManager.primary,
                      icon: AppIcons.wholesale,
                      logo: AppImages.basket,
                    ),
                    HomeContainer.square(
                      title: "إدارة التجزئة",
                      height: SizeConfig.screenHeight! * .23,
                      width: SizeConfig.screenWidth! * .42,
                      onTap: () => AppRoute().navigate(
                          context: context,
                          route: const ComingSoon(title: "إدارة التجزئة")),
                      color: ColorManager.lightPrimary,
                      icon: AppIcons.retialManagement,
                      logo: AppImages.bill,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: HomeContainer.rectangle(
                  title: tr(LocaleKeys.price_list),
                  height: SizeConfig.screenHeight! * .1,
                  width: SizeConfig.screenWidth!,
                  icon: AppIcons.pricesList,
                  color: ColorManager.green,
                  onTap: () => AppRoute().navigate(
                      context: context, route: const PriceListFilter.view()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeContainer.rectangle(
                      title: tr(LocaleKeys.sawaleef),
                      height: SizeConfig.screenHeight! * .1,
                      width: SizeConfig.screenWidth! * .42,
                      icon: AppIcons.swaleef,
                      color: ColorManager.secondary,
                      onTap: () => AppRoute().navigate(
                        context: context,
                        route: const SwalifPostsScreen(),
                      ),
                    ),
                    HomeContainer.rectangle(
                      title: tr(LocaleKeys.my_story),
                      height: SizeConfig.screenHeight! * .1,
                      width: SizeConfig.screenWidth! * .42,
                      icon: AppIcons.stories,
                      color: ColorManager.yellow,
                      onTap: () async {
                        AppRoute().navigate(
                            context: context, route: const MyStoriesScreen());
                      },
                    ),
                  ],
                ),
              ),
              const HomeNews(),
            ],
          ),
        ),
      ],
    );
  }
}
