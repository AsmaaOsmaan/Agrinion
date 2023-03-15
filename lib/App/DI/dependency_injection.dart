import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Utilities/network_info.dart';
import 'package:agriunion/Features/Account/Data/DataSource/profile_networking.dart';
import 'package:agriunion/Features/Account/Data/Repositories/profile_repo.dart';
import 'package:agriunion/Features/Account/Domain/service_layer.dart';
import 'package:agriunion/Features/Account/Presentation/ViewLogic/users_vl.dart';
import 'package:agriunion/Features/Ads/Data/DataSource/ad_networking.dart';
import 'package:agriunion/Features/Ads/Data/Repositories/ad_repository.dart';
import 'package:agriunion/Features/Ads/Domain/BusinessLogic/service_layer.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/Authentication/Data/DataSource/auth_network.dart';
import 'package:agriunion/Features/Authentication/Data/Repositories/auth_repository.dart';
import 'package:agriunion/Features/Authentication/Domain/service_layer.dart';
import 'package:agriunion/Features/Authentication/Presentation/ViewLogic/auth_view_logic.dart';
import 'package:agriunion/Features/Notification/Data/DataSource/notification_network.dart';
import 'package:agriunion/Features/Notification/Data/Repository/notification_repo.dart';
import 'package:agriunion/Features/Notification/Domain/ServiceLayer/notification_service_layer.dart';
import 'package:agriunion/Features/Notification/Presentation/ViewLogic/notification_vl.dart';
import 'package:agriunion/Features/Offers/Data/DataSourse/offers_network.dart';
import 'package:agriunion/Features/Offers/Data/DataSourse/sales_return_network.dart';
import 'package:agriunion/Features/Offers/Data/Repositories/offers_repo.dart';
import 'package:agriunion/Features/Offers/Data/Repositories/sales_return_repo.dart';
import 'package:agriunion/Features/Offers/Domain/ServiceLayer/offers_service_layer.dart';
import 'package:agriunion/Features/Offers/Domain/ServiceLayer/sales_returns_service_layer.dart';
import 'package:agriunion/Features/Offers/Presentation/ViewLogic/offers_vl.dart';
import 'package:agriunion/Features/Orders/Data/Repositories/orders_repo.dart';
import 'package:agriunion/Features/Orders/Domain/BusinessLogic/orders_service_layer.dart';
import 'package:agriunion/Features/Orders/Presentation/ViewLogic/orders_vl.dart';
import 'package:agriunion/Features/Payment/Data/DataSource/payment_network.dart';
import 'package:agriunion/Features/Payment/Data/Repositories/payment_repo.dart';
import 'package:agriunion/Features/Payment/Domain/ServiceLayer/payment_service_layer.dart';
import 'package:agriunion/Features/Payment/Presentation/ViewLogic/payment_vl.dart';
import 'package:agriunion/Features/PricesList/Data/Networking/price_list_networking.dart';
import 'package:agriunion/Features/PricesList/Data/Repositories/price_list_repository.dart';
import 'package:agriunion/Features/PricesList/Domain/Service/price_list_service.dart';
import 'package:agriunion/Features/PricesList/Presentation/ViewLogic/price_list_vl.dart';
import 'package:agriunion/Features/Reports/Data/Networking/invoices_networking.dart';
import 'package:agriunion/Features/Reports/Data/Networking/sales_report_networking.dart';
import 'package:agriunion/Features/Reports/Data/Repository/invoices_repository.dart';
import 'package:agriunion/Features/Reports/Data/Repository/sales_reports_repository.dart';
import 'package:agriunion/Features/Reports/Domian/Service/invoices_bl.dart';
import 'package:agriunion/Features/Reports/Domian/Service/reports_bl.dart';
import 'package:agriunion/Features/Reports/Presentation/ViewLogic/reports_vl.dart';
import 'package:agriunion/Features/Stories/Data/DataSource/story_networking.dart';
import 'package:agriunion/Features/Stories/Data/Repositories/story_repo.dart';
import 'package:agriunion/Features/Stories/Domain/ServiceLayer/service_layer.dart';
import 'package:agriunion/Features/Stories/Presentation/ViewLogic/story_vl.dart';
import 'package:agriunion/Features/Swalif/Data/DataSource/swalif_network.dart';
import 'package:agriunion/Features/Swalif/Data/Repositories/swalif_repo.dart';
import 'package:agriunion/Features/Swalif/Domain/ServiceLayer/swalif_service_layer.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Data/DataSourse/categories_network.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Data/Repositories/categories_repositories.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/ServiceLayer/service_layer.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Presentation/Logic/categories_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Data/DataSourse/cities_network.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Data/Repositories/cities_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/ServiceLayer/service_layer.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Presentation/Logic/cities_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Data/DataSourse/markets_network.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Data/Repositories/markets_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/ServiceLayer/service_layer.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Presentation/Logic/markets_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Data/DataSourse/products_network.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Data/Repositories/products_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/ServiceLayer/service_layer.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Presentation/Logic/products_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Data/DataSourse/unit_types_network.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Data/Repositories/unit_types_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/ServiceLayer/service_layer.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Presentation/Logic/unit_types_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/DataSource/broker_management_network.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/Repositories/broker_management_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/ServiceLayer/service_layer.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/presentaion/logic/broker_management_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Data/DataSourse/user_managment_network.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Data/Repositories/user_managment_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/ServiceLayer/service_layer.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Presentation/Logic/user_managment_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Data/DataSource/linking_user_requests_networking.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Data/Repositories/linking_user_requests_repo.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Service/linking_users_requests_bl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/ViewLogic/linking_users_requests_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Data/DataSource/broker_requests_networking.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Data/Repositories/brokers_to_market_requests_repo.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Domain/Service/broker_requests_bl.dart';
import 'package:agriunion/Features/cart/Domain/ServiceLayer/cart_service_layer.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/cart_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/global_ads_cart_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/my_ads_cart_vl.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../Features/News/Data/DataSource/news_networking.dart';
import '../../Features/News/Data/Repositories/news_repo.dart';
import '../../Features/News/Domain/ServiceLayer/news_service_layer.dart';
import '../../Features/News/Presentation/ViewLogic/news_vl.dart';
import '../../Features/Orders/Data/DataSource/orders_network.dart';
import '../../Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/DataSource/brokers_network.dart';
import '../../Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/Repositories/brokers_repo_impl.dart';
import '../../Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/ViewLogic/brokers_to_market_requests_vl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Datasources
  sl.registerLazySingleton(() => NetworkHelper());
  sl.registerLazySingleton<NetWorkInfo>(() => NetworkInfoImpl(sl()));
  //! Broker
  brokerResourceDI();

//! USERS
  userResourceDI();
//! ADS
  adsResourceDI();
  //! OFFERS
  offersResourceDI();
//! BROKERS TO MARKET REQUESTS
  brokerToMarketResourceDI();
  //Cart
  cartResourceDI();
  //Orders
  orderResourceDI();
  salesReturnResourceDI();
  //linking Users Requests Resource
  linkingUsersRequestsResourceDI();
  unitTypeResourceDI();
  // Price List
  priceListResourceDI();
  marketResourceDI();
  productResourceDI();
  categoryResourceDI();
  cityResourceDI();
  authResourceDI();
  storyResourceDI();
  newsResourceDI();
  invoicesResourceDI();
  swalifResourceDI();
  notificationResourceDI();
  paymentResourceDI();
  reportsResourceDI();
//! Externals
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

void brokerResourceDI() {
  sl.registerLazySingleton<IBrokerNetworking>(() => BrokersNetworking(sl()));
  sl.registerLazySingleton<IBrokersRepository>(() => BrokersRepository(sl()));
}

void userResourceDI() {
  sl.registerLazySingleton<IProfileNetworking>(() => ProfileNetworking(sl()));
  sl.registerLazySingleton<IProfileRepository>(() => ProfileRepository(sl()));
  sl.registerLazySingleton<IProfileService>(() => ProfileService(sl()));
  sl.registerLazySingleton(() => UsersVL(sl()));

  sl.registerLazySingleton<IBrokerManagementNetworking>(
      () => BrokerManagementNetworking(sl()));
  sl.registerLazySingleton<IBrokerManagementRepository>(
      () => BrokerManagementRepository(sl()));
  sl.registerLazySingleton<IBrokerManagementService>(
      () => BrokerManagementService(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => BrokerManageVL(sl()));

  sl.registerLazySingleton<IUserManagementNetworking>(
      () => UserManagementNetworking(sl()));
  sl.registerLazySingleton<IUserManagementRepository>(
      () => UserManagementRepository(sl()));
  sl.registerLazySingleton<IUserManagementService>(
      () => UserManagmentService(sl()));
  sl.registerLazySingleton(() => UserManagementVL(sl()));
}

void brokerToMarketResourceDI() {
  sl.registerLazySingleton<IBorkerToMarketRequestsNetworking>(
      () => BrokerToMarketRequestsNetworking(sl()));
  sl.registerLazySingleton<IBrokerToMarketRequestsRepository>(
      () => BrokerToMarketRequestRepository(sl()));
  sl.registerLazySingleton<IBrokerRequestsBL>(
      () => BrokerToMarketRequestsBL(sl()));
  sl.registerLazySingleton(() => BrokersToMarketRequestsVL(sl()));
}

void adsResourceDI() {
  sl.registerLazySingleton<IAdNetworking>(() => AdNetworking(sl()));
  sl.registerLazySingleton<IAdsRepository>(() => AdsRepository(sl()));
  sl.registerLazySingleton<IAdService>(
      () => AdService(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => AdsVL(sl()));
}

void orderResourceDI() {
  sl.registerLazySingleton<IOrdersNetworking>(() => OrdersNetworking(sl()));
  sl.registerLazySingleton<IOrdersRepository>(() => OrdersRepository(sl()));
  sl.registerLazySingleton<IOrdersBL>(() => OrdersBL(sl()));
  sl.registerLazySingleton(() => OrdersVL(sl()));
}

void invoicesResourceDI() {
  sl.registerLazySingleton<IInvoicesNetworking>(() => InvoicesNetworking(sl()));
  sl.registerLazySingleton<IInvoicesRepository>(() => InvoicesRepository(sl()));
  sl.registerLazySingleton<IInvoicesBL>(() => InvoicesBL(sl()));
}

void salesReturnResourceDI() {
  sl.registerLazySingleton<ISalesReturnNetworking>(
      () => SalesReturnNetworking(sl()));
  sl.registerLazySingleton<ISalesReturnsRepository>(
      () => SalesReturnsRepository(sl()));
  sl.registerLazySingleton<ISalesReturnsBL>(() => SalesReturnsBL(sl()));
}

void offersResourceDI() {
  sl.registerLazySingleton<IOffersNetworking>(() => OffersNetworking(sl()));
  sl.registerLazySingleton<IOffersRepository>(() => OffersRepository(sl()));
  sl.registerLazySingleton<IOffersService>(() => OffersService(sl()));
  sl.registerLazySingleton(() => OffersVL(sl(), sl(), sl()));
}

void cartResourceDI() {
  sl.registerLazySingleton<ICartService>(() => CartService(sl(), sl()));
  sl.registerLazySingleton(() => CartVL(sl()));
  sl.registerLazySingleton(() => MyAdsCartVL(sl()));
  sl.registerLazySingleton(() => GlobalAdsCartVL(sl()));
}

void unitTypeResourceDI() {
  sl.registerLazySingleton<IUnitTypesNetworking>(
      () => UnitTypesNetworking(sl()));
  sl.registerLazySingleton<IUnitTypeRepository>(() => UnitTypeRepository(sl()));
  sl.registerLazySingleton<IUnitTypesService>(() => UnitTypesService(sl()));
  sl.registerLazySingleton(() => UnitTypesVL(sl()));
}

void productResourceDI() {
  sl.registerLazySingleton<IProductsNetworking>(() => ProductsNetworking(sl()));
  sl.registerLazySingleton<IProductsRepository>(() => ProductsRepository(sl()));
  sl.registerLazySingleton<IProductsService>(() => ProductsService(sl()));
  sl.registerLazySingleton(() => ProductsVL(sl()));
}

void cityResourceDI() {
  sl.registerLazySingleton<ICitiesNetworking>(() => CitiesNetworking(sl()));
  sl.registerLazySingleton<ICitiesRepository>(() => CitiesRepository(sl()));
  sl.registerLazySingleton<ICitiesService>(() => CitiesService(sl()));
  sl.registerLazySingleton(() => CitiesVL(sl()));
}

void categoryResourceDI() {
  sl.registerLazySingleton<ICategoriesNetworking>(
      () => CategoriesNetworking(sl()));
  sl.registerLazySingleton<ICategoriesRepository>(
      () => CategoriesRepository(sl()));
  sl.registerLazySingleton<ICategoriesService>(() => CategoriesService(sl()));
  sl.registerLazySingleton(() => CategoriesVL(sl()));
}

void authResourceDI() {
  sl.registerLazySingleton<IAuthNetworking>(() => AuthNetworking(sl()));
  sl.registerLazySingleton<IAuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<IAuthService>(() => AuthService(sl(), sl(), sl()));
  sl.registerLazySingleton(() => AuthVL(sl()));
}

void marketResourceDI() {
  sl.registerLazySingleton<IMarketsNetworking>(() => MarketsNetworking(sl()));
  sl.registerLazySingleton<IMarketsRepository>(() => MarketsRepository(sl()));
  sl.registerLazySingleton<IMarketsService>(() => MarketsService(sl()));
  sl.registerLazySingleton(() => MarketsVL(sl()));
}

void storyResourceDI() {
  sl.registerLazySingleton<IStoryNetworking>(() => StoryNetworking(sl()));
  sl.registerLazySingleton<IStoryRepository>(() => StoryRepository(sl()));
  sl.registerLazySingleton<IStoryServiceLayer>(() => StoryServiceLayer(sl()));
  sl.registerLazySingleton(() => StoryVL(sl()));
}

void linkingUsersRequestsResourceDI() {
  sl.registerLazySingleton<ILinkingUserRequestsNetworking>(
      () => LinkingUserRequestsNetworking(sl()));
  sl.registerLazySingleton<ILinkingUserRequestsRepository>(
      () => LinkingUserRequestsRepository(sl()));
  sl.registerLazySingleton<ILinkingUsersRequestsServiceLayer>(
      () => LinkingUsersRequestsServiceLayer(sl(), sl()));
  sl.registerLazySingleton(() => LinkingUsersRequestsVL(sl()));
}

void newsResourceDI() {
  sl.registerLazySingleton<INewsNetworking>(() => NewsNetworking(sl()));
  sl.registerLazySingleton<INewsRepository>(() => NewsRepository(sl()));
  sl.registerLazySingleton<INewsServiceLayer>(() => NewsServiceLayer(sl()));
  sl.registerLazySingleton(() => NewsVL(sl()));
}

void swalifResourceDI() {
  sl.registerLazySingleton<ISwalifNetworking>(() => SwalifNetworking(sl()));
  sl.registerLazySingleton<ISwalifRepository>(() => SwalifRepository(sl()));
  sl.registerLazySingleton<ISwalifServiceLayer>(() => SwalifServiceLayer(sl()));
  sl.registerLazySingleton(() => SwalifVL(sl()));
}

void notificationResourceDI() {
  sl.registerLazySingleton<INotificationNetworking>(
      () => NotificationNetworking(sl()));
  sl.registerLazySingleton<INotificationRepo>(() => NotificationRepo(sl()));
  sl.registerLazySingleton<INotificationServiceLayer>(
      () => NotificationServiceLayer(sl()));
  sl.registerLazySingleton(() => NotificationVL(sl()));
}

void paymentResourceDI() {
  sl.registerLazySingleton<IPaymentNetworking>(() => PaymentNetworking(sl()));
  sl.registerLazySingleton<IPaymentRepository>(() => PaymentRepository(sl()));
  sl.registerLazySingleton<IPaymentService>(() => PaymentService(sl()));
  sl.registerLazySingleton(() => PaymentVL(sl()));
}

void priceListResourceDI() {
  sl.registerLazySingleton<IPriceListNetworking>(
      () => PriceListNetworking(sl()));
  sl.registerLazySingleton<IPriceListRepo>(() => PriceListRepo(sl()));
  sl.registerLazySingleton<IPriceListBL>(
      () => PriceListBL(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => PriceListVL(sl()));
}

void reportsResourceDI() {
  sl.registerLazySingleton<ISalesReportsNetworking>(
      () => SalesReportsNetworking(sl()));
  sl.registerLazySingleton<ISalesReportsRepository>(
      () => SalesReportsRepository(sl()));
  sl.registerLazySingleton<IReportsBL>(() => ReportsBL(sl()));
  sl.registerLazySingleton(() => ReportsVL(sl()));
}
