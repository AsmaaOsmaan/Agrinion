import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/App/Utilities/api_handler.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/Features/Ads/Domain/BusinessLogic/service_layer.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_favourit_model.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_filter_model.dart';
import 'package:agriunion/Features/Ads/Domain/Models/add_ad_model.dart';
import 'package:agriunion/Features/Ads/Domain/Models/delete_ad_model.dart';
import 'package:agriunion/Features/Ads/Presentation/Widgets/stepper.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/markets_mixin.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:agriunion/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../App/Utilities/utils.dart';
import '../../../../App/constants/strings.dart';
import '../../../SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import '../../../SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';
import '../../Domain/Models/ad_model.dart';
import '../../Domain/product_entity.dart';
import 'categories_mixin.dart';

class AdsVL extends ChangeNotifier with CategoriesMixin, MarketMixin {
  final IAdService _service;
  AdsVL(this._service);
  int activeStep = 0;
  List<int> steps = [1, 2, 3, 4, 5, 6, 7, 8];
  bool isLoading = false;

  moveStep(int index) {
    activeStep = index;
    notifyListeners();
  }

// Cities Module
  List<Cities> cities = [];
  Cities? city;
  getCities() async {
    cities = await _service.getCities();
    notifyListeners();
  }

  setAllCitiesWithFalse() {
    for (var cty in cities) {
      cty.isSelected = false;
    }
  }

  changeCityStep(Cities city, [int? index]) async {
    setCity(city, index);
    moveToNextStep();
    await getMarkets(city, _service);
    notifyListeners();
  }

  void setCity(Cities city, int? index) {
    this.city = city;
    setAllCitiesWithFalse();
    cities[index!].isSelected = true;
  }

// Markets Module

  @override
  changeMarketStep(Market market, int index, String type) async {
    super.changeMarketStep(market, index, type);
    moveToNextStep();
    await getProducts(category!.id!);
    await dataToGetAfterMarketStep(type, market);
    notifyListeners();
  }

  Future<void> dataToGetAfterMarketStep(String? type, Market market) async {
    type == 'Broker' ? await getFarmers() : {};
    await getBrokers(market.id!);
  }

  // Broker module

  List<Broker> brokers = [];
  Broker? broker;
  getBrokers(int marketId) async {
    brokers = await _service.getBrokers(marketId);
    notifyListeners();
  }

  setBroker(Broker? broker) {
    this.broker = broker;
    notifyListeners();
  }

// Commercial Profile module
  List<CommercialProfileModel> farmers = [];
  CommercialProfileModel? farmer;
  getFarmers() async {
    farmers = await _service.getFarmers();
    notifyListeners();
  }

  setFarmer(CommercialProfileModel? farmer) {
    this.farmer = farmer;
    notifyListeners();
  }

// Product Module
  List<Product> products = [];
  Product? product;
  getProducts(int categoryId) async {
    products = await _service.getProductsPerCategory(categoryId);
    notifyListeners();
  }

  setProduct(Product? product) async {
    this.product = product;
    notifyListeners();
  }

  // UnitTypes Module
  List<UnitType> unitTypes = [];
  UnitType? unitType;
  getUnitTypes() async {
    unitTypes = await _service.getUnitTypes();
    notifyListeners();
  }

  setUnitType(UnitType? unitType) {
    this.unitType = unitType;
    notifyListeners();
  }

  File? image;
  void getProductImage() async {
    image = await Utils.getImage();
    notifyListeners();
  }

  List<AdProductEntity> adProducts = [];
  late AdProductEntity adProduct;

  void addToProducts(AdProductEntity product) {
    adProducts.add(product);
    activeStep++;
    notifyListeners();
  }

  resetProduct() {
    image = null;
    product = null;
    unitType = null;
    clonedAd = null;
    notifyListeners();
  }

  void previousStep() {
    activeStep--;
    notifyListeners();
  }

  void moveToNextStep() {
    activeStep++;
    notifyListeners();
  }

  void removeFromProducts(AdProductEntity product) {
    adProducts.remove(product);
    notifyListeners();
  }

  void manageAdsCreation(BuildContext context) async {
    try {
      for (var index = 0; index <= adProducts.length - 1; index++) {
        AddAdModel model = fillTheModel(index);
        await addingTheAd(model, index);
      }
      checkWetherTheProductsCreatedSuccessfully(context);
      notifyListeners();
    } on Exception catch (e) {
      APIHandler.handleExceptions(e);
      EasyLoading.dismiss();
    }
    notifyListeners();
  }

  void checkWetherTheProductsCreatedSuccessfully(BuildContext context) {
    bool isAllDone = adProducts.where((element) => !element.isDone).isEmpty;
    if (isAllDone) onAdsCreationDone(context);
  }

  bool negotiable = false;
  void adNegotiable(bool value) {
    negotiable = value;
    notifyListeners();
  }

  AddAdModel fillTheModel(int index) {
    var model = AddAdModel(
        image: adProducts[index].image,
        marketId: market!.id!,
        categoryId: category!.id!,
        productId: adProducts[index].id!,
        price: adProducts[index].price,
        quantity: adProducts[index].unitCount,
        unitWeight: adProducts[index].unitWeight,
        unitTypeId: adProducts[index].unitType,
        brokerId: broker == null ? null : broker!.id,
        negotiable: negotiable,
        commercialProfileId: farmer == null ? null : farmer!.id);
    return model;
  }

  Future<void> addingTheAd(AddAdModel model, int index) async {
    LoadingDialog.showLoadingDialog();
    AdModel ad = await _service.createAd(model);
    ads.add(ad);
    EasyLoading.dismiss();
    adProducts[index].isDone = (ad.id != null);
  }

  void onAdsCreationDone(BuildContext context) {
    Navigator.pop(context);
    clearLastAdCreation();
  }

  List<AdModel> ads = [];
  List<AdModel> myAds = [];
  List<AdModel> adsByCategory = [];

  Future<void> getAds() async {
    isLoading = true;
    ads = await _service.getAds();
    isLoading = false;
    notifyListeners();
  }

  AdFilter? filter;
  Future<void> filterAds() async {
    isLoading = true;
    ads = await _service.filterAds(filter!);
    Navigator.of(navKey.currentContext!).pop();
    isLoading = false;
    notifyListeners();
  }

  clearFiltersData() {
    filterCategory = null;
    filterCity = null;
    filterMarket = null;
    notifyListeners();
  }

  clearFilter() {
    clearFiltersData();
    getAds();
  }

  Future<void> getMyAds() async {
    isLoading = true;
    myAds = await _service.getMyAds();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAdsByCategory(Categories category) async {
    isLoading = true;
    if (category.isCategoryGroup) {
      adsByCategory = await _service.getAdsByCategoryGroup(category.id!);
    } else {
      adsByCategory = await _service.getAdsByCategory(category.id!);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAdsBySubCategory(Categories category, int index) async {
    isLoading = true;
    adsByCategory = await _service.getAdsByCategory(category.id!);
    changeLabelColor(index);
    isLoading = false;

    notifyListeners();
  }

  bool isFav = true;
  updateFavVal() {
    isFav = !isFav;
    notifyListeners();
  }

  bool inMyFavoriteScreen = false;
  manageFavoriteAd(int adId, bool isFavorited) {
    if (isFavorited == false) {
      favoriteAd(adId);
    } else {
      unFavoriteAd(adId);
    }
    if (inMyFavoriteScreen) {
      myFavoriteAds[myFavoriteAds.indexWhere((element) => element.id == adId)]
          .isFav = !isFavorited;
    } else {
      ads[ads.indexWhere((element) => element.id == adId)].isFav = !isFavorited;
    }

    notifyListeners();
  }

  updateValueInFavoriteScreen(bool val) {
    inMyFavoriteScreen = val;
    notifyListeners();
  }

  showAdDetails(int adId) async {
    AdModel adDetails = await _service.showAdDetails(adId);
    isFav = adDetails.isFav!;
    notifyListeners();
  }

  changeLabelColor(int index) {
    for (var element in subCategories) {
      if (element.isSelected) {
        element.isSelected = false;
      }
    }
    subCategories[index].isSelected = !subCategories[index].isSelected;
  }

  void close(BuildContext context) {
    image = null;
    Navigator.pop(context);
  }

  void clearLastAdCreation() {
    category = null;
    clearBroker();
    adProducts.clear();
    city = null;
    market = null;
    activeStep = 0;
    product = null;
    unitType = null;
    negotiable = false;
    clearFarmer();
    clonedAd = null;
    setAllCategoriesWithFalse();
  }

  void clearBroker() {
    broker = null;
    notifyListeners();
  }

  void clearFarmer() {
    farmer = null;
    notifyListeners();
  }

  getCategories() async {
    await super.getCategoriesFromMixin(_service);
    notifyListeners();
  }

  @override
  setSubCategory(int index) {
    super.setSubCategory(index);
    moveToNextStep();
    notifyListeners();
  }

  setCategory(Categories category, int index) async {
    subCategories.clear();

    if (category.isCategoryGroup) {
      await setCategoryIfItsGroup(category);
    } else {
      await setIfNotGroup(index, category);
    }
    notifyListeners();
  }

  Future<void> setIfNotGroup(int index, Categories category) async {
    setAllCategoriesWithFalse();
    categories[index].isSelected = true;
    this.category = category;
    getCities();
    moveToNextStep();
    moveToNextStep();
  }

  Future<void> getSubCategories(Categories category) async {
    subCategories.clear();
    if (category.type != "Category") {
      subCategories = await _service.getCategoriesPerCategory(category.id!);
    }
    notifyListeners();
  }

  Future<void> setCategoryIfItsGroup(Categories category) async {
    this.category = category;
    subCategories = await _service.getCategoriesPerCategory(category.id!);
    moveToNextStep();
  }

  AdModel? clonedAd;
  cloneFromPreviousApp(AdModel ad, BuildContext context) async {
    clonedAd = ad;
    category = ad.category;
    product = ad.product;
    unitType = ad.unitType;
    city = ad.city;
    market = ad.market;
    farmer = ad.commercialProfile;
    broker = ad.broker;
    LoadingDialog.showLoadingView();
    await getProducts(clonedAd!.category!.id!);
    EasyLoading.dismiss();
    activeStep = 4;
    AppRoute().navigate(context: context, route: const StepperDemo());
  }

  Future<void> deleteAd(AdModel ad) async {
    try {
      LoadingDialog.showLoadingDialog();
      DeleteAdError? model = await _service.deleteAd(ad.id!);
      EasyLoading.dismiss();
      if (model == null) {
        LoadingDialog.showSimpleToast(tr(LocaleKeys.successDelete));
        myAds.remove(ad);
        notifyListeners();
      } else {
        LoadingDialog.showSimpleToast(model.errorMsg);
      }
    } on Exception catch (e) {
      EasyLoading.dismiss();

      if (e is UnAuthorizeException) {
        LoadingDialog.showSimpleToast("This Entity has associated data");
      }
    }
  }

  Future<void> favoriteAd(int adId) async {
    await _service.favoriteAd(AdFavoriteModel(adId: adId));
    notifyListeners();
  }

  Future<void> unFavoriteAd(int adId) async {
    await _service.unFavoriteAd(adId);
    notifyListeners();
  }

  List<AdModel> myFavoriteAds = [];
  Future<void> getAllFavoriteAds() async {
    myFavoriteAds = await _service.getAllFavoriteAds();

    notifyListeners();
  }

  // Filter Ads
  Categories? filterCategory;
  Cities? filterCity;
  Market? filterMarket;
  setCategoryToFilter(Categories? value) {
    filterCategory = value;
    notifyListeners();
  }

  setCityToFilter(Cities? value) async {
    filterCity = value;
    await getMarkets(value!, _service);
    notifyListeners();
  }

  setMarketToFilter(Market? value) {
    filterMarket = value;
    notifyListeners();
  }
}
