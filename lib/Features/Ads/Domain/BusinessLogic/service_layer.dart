import 'package:agriunion/Features/Ads/Data/Repositories/ad_repository.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_favourit_model.dart';
import 'package:agriunion/Features/Ads/Domain/Models/delete_ad_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Data/Repositories/categories_repositories.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Data/Repositories/cities_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Data/Repositories/markets_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Data/Repositories/products_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Data/Repositories/unit_types_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/Repositories/brokers_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Data/Repositories/user_managment_repo_impl.dart';

import '../../../SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';
import '../Models/ad_filter_model.dart';
import '../Models/ad_model.dart';
import '../Models/add_ad_model.dart';

abstract class IAdService {
  Future<List<AdModel>> getAds();
  Future<List<AdModel>> getMyAds();
  Future<List<AdModel>> getAdsByCategory(int categoryId);
  Future<List<AdModel>> getAdsByCategoryGroup(int categoryGroupId);
  Future<List<AdModel>> filterAds(AdFilter filter);
  Future<AdModel> createAd(AddAdModel model);
  Future<AdModel> showAdDetails(int adId);
  Future<AdModel> updateAd(AdModel model, AddAdModel adModel);
  Future<DeleteAdError?> deleteAd(int adId);
  Future<List<Product>> getProductsPerCategory(int categoryId);
  Future<List<Cities>> getCities();
  Future<List<Market>> getMarkets(int cityId);
  Future<List<Categories>> getCategories();
  Future<List<Categories>> getCategoriesPerCategory(int categoryId);
  Future<List<UnitType>> getUnitTypes();
  Future<List<Broker>> getBrokers(int marketId);
  Future<List<CommercialProfileModel>> getFarmers();
  Future<AdFavoriteModel> favoriteAd(AdFavoriteModel adFavoriteModel);
  Future<void> unFavoriteAd(int adId);
  Future<List<AdModel>> getAllFavoriteAds();
}

class AdService implements IAdService {
  IAdsRepository repo;
  final IUserManagementRepository _userManagementRepository;
  final IUnitTypeRepository _unitTypeRepository;
  final IMarketsRepository _marketRepository;
  final IProductsRepository _productRepository;
  final ICategoriesRepository _categoryRepository;
  final ICitiesRepository _cityRepository;
  final IBrokersRepository _brokerRpo;

  AdService(
      this.repo,
      this._userManagementRepository,
      this._unitTypeRepository,
      this._marketRepository,
      this._productRepository,
      this._categoryRepository,
      this._brokerRpo,
      this._cityRepository);
  @override
  Future<List<AdModel>> getAds() async {
    try {
      return await repo.getAds();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AdModel>> getAllFavoriteAds() async {
    return await repo.getAllFavoriteAds();
  }

  @override
  Future<List<AdModel>> getMyAds() async {
    try {
      return await repo.getMyAds();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AdModel>> getAdsByCategory(int categoryId) async {
    try {
      return await repo.getAdsByCategory(categoryId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AdModel>> getAdsByCategoryGroup(int categoryGroupId) async {
    try {
      return await repo.getAdsByCategoryGroup(categoryGroupId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AdModel>> filterAds(AdFilter filter) async {
    try {
      return await repo.filterAds(filter);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdModel> createAd(AddAdModel model) async {
    try {
      return await repo.createAd(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdModel> showAdDetails(int adId) async {
    try {
      return await repo.showAdDetails(adId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdModel> updateAd(AdModel model, AddAdModel adModel) async {
    try {
      return await repo.updateAd(model, adModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeleteAdError?> deleteAd(int adId) async {
    try {
      DeleteAdError? model = await repo.deleteAd(adId);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProductsPerCategory(int categoryId) async {
    return await _productRepository.getProductsPerCategoryId(categoryId);
  }

  @override
  Future<List<Cities>> getCities() async {
    return await _cityRepository.getCities();
  }

  @override
  Future<List<Market>> getMarkets(int cityId) async {
    return await _marketRepository.getMarkets(cityId);
  }

  @override
  Future<List<Categories>> getCategories() async {
    return await _categoryRepository.getMainCategories();
  }

  @override
  Future<List<Categories>> getCategoriesPerCategory(int categoryId) async {
    return await _categoryRepository.getCategoriesPerCategory(categoryId);
  }

  @override
  Future<List<UnitType>> getUnitTypes() async {
    return await _unitTypeRepository.getUnitType();
  }

  @override
  Future<List<Broker>> getBrokers(int marketId) async {
    return await _brokerRpo.getBrokers(marketId);
  }

  @override
  Future<List<CommercialProfileModel>> getFarmers() async {
    return await _userManagementRepository.getFarmersCommercialProfiles();
  }

  @override
  Future<AdFavoriteModel> favoriteAd(AdFavoriteModel adFavoriteModel) async {
    return await repo.favoriteAd(adFavoriteModel);
  }

  @override
  Future<void> unFavoriteAd(int adId) async {
    await repo.unFavoriteAd(adId);
  }
}
