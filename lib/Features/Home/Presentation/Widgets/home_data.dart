part of 'home_imports.dart';

class HomeData {
  final GlobalKey<ScaffoldState> scaffold = GlobalKey();
  final GenericCubit<int> navCubit = GenericCubit(0);
  AnimationController? animationController;
  TabController? tabController;
  Animation<double>? animation;
  CurvedAnimation? curve;
  int currentIndex = 0;

  List<BottomTabModel> tabs = [
    BottomTabModel(AppIcons.main, tr(LocaleKeys.home)),
    BottomTabModel(AppIcons.wholesale, tr(LocaleKeys.ads)),
    BottomTabModel(AppIcons.cart, tr(LocaleKeys.cart)),
    BottomTabModel(AppIcons.retialManagement, "إدارة التجزئة"),
    BottomTabModel(AppIcons.more, tr(LocaleKeys.more)),
  ];

  void initBottomNavigation(TickerProvider ticker) {
    tabController = TabController(length: 5, vsync: ticker);
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: ticker,
    );
    curve = CurvedAnimation(
      parent: animationController!,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve!);
    Future.delayed(
      const Duration(seconds: 1),
      () => animationController!.forward(),
    );
  }

  Future<bool> onBackPressed() async {
    SystemNavigator.pop();
    return false;
  }

  void animateTabsPages(int index, BuildContext context) {
    navCubit.onUpdateData(index);
    tabController!.animateTo(index);
  }

  void cartClick(BuildContext context) {
    tabController!.animateTo(4);
    navCubit.onUpdateData(4);
  }
}
