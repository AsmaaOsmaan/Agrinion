import 'package:agriunion/App/constants/pathes.dart';
import 'package:agriunion/Features/Account/Presentation/ViewLogic/users_vl.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/Authentication/Presentation/ViewLogic/auth_view_logic.dart';
import 'package:agriunion/Features/Intro/Presentation/Screens/splash_screen.dart';
import 'package:agriunion/Features/Notification/Presentation/ViewLogic/notification_vl.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/Features/Orders/Presentation/ViewLogic/orders_vl.dart';
import 'package:agriunion/Features/Payment/Presentation/ViewLogic/payment_vl.dart';
import 'package:agriunion/Features/PricesList/Presentation/ViewLogic/price_list_vl.dart';
import 'package:agriunion/Features/Reports/Presentation/ViewLogic/reports_vl.dart';
import 'package:agriunion/Features/Stories/Presentation/ViewLogic/story_vl.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Presentation/Logic/cities_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Presentation/Logic/markets_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Presentation/Logic/products_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Presentation/Logic/unit_types_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/logic/broker_management_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Presentation/Logic/user_managment_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/ViewLogic/linking_users_requests_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/cart_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/global_ads_cart_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/my_ads_cart_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'App/DI/dependency_injection.dart' as di;
import 'App/DI/dependency_injection.dart';
import 'App/GenericBloC/generic_cubit.dart';
import 'App/Resources/application_theme.dart';
import 'App/Utilities/cache_helper.dart';
import 'App/Utilities/global_notification.dart' as gn;
import 'App/Utilities/scroll_behaviour.dart';
import 'Features/News/Presentation/ViewLogic/news_vl.dart';
import 'Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Logic/categories_vl.dart';
import 'Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/ViewLogic/brokers_to_market_requests_vl.dart';
import 'firebase_options.dart';

void main() async {
  if (kDebugMode) {
    await dotenv.load(fileName: '.env.test');
  } else {
    await dotenv.load(fileName: '.env');
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Agriunion',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(
      gn.firebaseMessahangingBackgroundHandler);
  await EasyLocalization.ensureInitialized();
  await di.init();

  await CachHelper.init();

  runApp(EasyLocalization(
    path: localePath,
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
    startLocale: const Locale('ar', 'EG'),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  _MyAppState createState() => _MyAppState();
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GenericCubit(false)),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AdsVL(sl())),
          ChangeNotifierProvider(create: (context) => AuthVL(sl())),
          ChangeNotifierProvider(create: (context) => CitiesVL(sl())),
          ChangeNotifierProvider(create: (context) => MarketsVL(sl())),
          ChangeNotifierProvider(create: (context) => ProductsVL(sl())),
          ChangeNotifierProvider(create: (context) => CategoriesVL(sl())),
          ChangeNotifierProvider(create: (context) => BrokerManageVL(sl())),
          ChangeNotifierProvider(create: (context) => UnitTypesVL(sl())),
          ChangeNotifierProvider(create: (context) => UserManagementVL(sl())),
          ChangeNotifierProvider(
              create: (context) => OffersVL(sl(), sl(), sl())),
          ChangeNotifierProvider(create: (context) => UsersVL(sl())),
          ChangeNotifierProvider(create: (context) => CartVL(sl())),
          ChangeNotifierProvider(create: (context) => MyAdsCartVL(sl())),
          ChangeNotifierProvider(create: (context) => GlobalAdsCartVL(sl())),
          ChangeNotifierProvider(create: (context) => OrdersVL(sl())),
          ChangeNotifierProvider(
            create: (context) => BrokersToMarketRequestsVL(sl()),
          ),
          ChangeNotifierProvider(
            create: (context) => LinkingUsersRequestsVL(sl()),
          ),
          ChangeNotifierProvider(create: (context) => StoryVL(sl())),
          ChangeNotifierProvider(create: (context) => NewsVL(sl())),
          ChangeNotifierProvider(create: (context) => SwalifVL(sl())),
          ChangeNotifierProvider(create: (context) => NotificationVL(sl())),
          ChangeNotifierProvider(create: (context) => PriceListVL(sl())),
          ChangeNotifierProvider(create: (context) => PaymentVL(sl())),
          ChangeNotifierProvider(create: (context) => ReportsVL(sl()))
        ],
        child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: navKey,
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            home: const SplashScreen(),
            builder: (ctx, child) {
              EasyLoading.init();
              child = FlutterEasyLoading(child: child);
              return ScrollConfiguration(
                behavior: const ScrollBehaviorModified(),
                child: child,
              );
            }),
      ),
    );
  }
}
