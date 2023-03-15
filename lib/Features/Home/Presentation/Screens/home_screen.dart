import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../App/GenericBloC/generic_cubit.dart';
import '../../../../App/GlobalWidgets/BottomNavBar/tab_icon.dart';
import '../../../Ads/Presentation/view_logic/ad_vl.dart';
import '../../../Markets/Presentation/Screeens/wholesale_market.dart';
import '../../../RetailManagement/Presentation/Screens/retail_management.dart';
import '../../../cart/Presention/screens/cart_screen.dart';
import '../Widgets/home_imports.dart';
import 'main_screen.dart';
import 'more.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeData homeData = HomeData();

  @override
  void initState() {
    homeData.initBottomNavigation(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (homeData.navCubit.state.data != 0) {
          homeData.animateTabsPages(0, context);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: DefaultTabController(
        length: 5,
        initialIndex: 0,
        child: Scaffold(
          key: homeData.scaffold,
          body: TabBarView(
            controller: homeData.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MainScreen(
                changeIndex: (index) =>
                    homeData.animateTabsPages(index, context),
              ),
              const WholesaleStores(),
              const CartScreen(),
              const RetailManagement(),
              const MoreScreen(),
            ],
          ),
          bottomNavigationBar:
              BlocBuilder<GenericCubit<int>, GenericState<int>>(
            bloc: homeData.navCubit,
            builder: (context, state) {
              return _buildBottomNavigationBar(state.data);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(int current) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: 5,
      tabBuilder: (int index, bool isActive) {
        return TabIcon(index: index, active: isActive);
      },
      backgroundColor: Colors.white,
      splashColor: Colors.white,
      activeIndex: current,
      notchAndCornersAnimation: homeData.animation,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.end,
      gapWidth: 0,
      height: 65,
      onTap: (index) async {
        if (index == 1) {
          context.read<AdsVL>().getAds();
        }
        homeData.animateTabsPages(index, context);
      },
    );
  }

  @override
  void dispose() {
    homeData.tabController!.dispose();
    homeData.animationController!.dispose();
    super.dispose();
  }
}
