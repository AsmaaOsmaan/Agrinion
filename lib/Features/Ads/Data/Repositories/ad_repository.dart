import 'package:agriunion/Features/Ads/Data/DataSource/ad_networking.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_favourit_model.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_filter_model.dart';
import 'package:agriunion/Features/Ads/Domain/Models/ad_model.dart';
import 'package:agriunion/Features/Ads/Domain/Models/delete_ad_model.dart';

import '../../../../App/Utilities/utils.dart';
import '../../Domain/Models/add_ad_model.dart';
import '../Mappers/ad_favorite_mapper.dart';
import '../Mappers/ad_mapper.dart';

abstract class IAdsRepository {
  Future<List<AdModel>> getAds();
  Future<List<AdModel>> getMyAds();
  Future<List<AdModel>> getAdsByCategory(int categoryId);
  Future<List<AdModel>> getAdsByCategoryGroup(int categoryGroupId);
  Future<List<AdModel>> filterAds(AdFilter filter);
  Future<AdModel> showAdDetails(int adId);
  Future<AdModel> createAd(AddAdModel model);
  Future<AdModel> updateAd(AdModel model, AddAdModel adModel);
  Future<DeleteAdError?> deleteAd(int adId);
  Future<void> unFavoriteAd(int adId);
  Future<AdFavoriteModel> favoriteAd(AdFavoriteModel model);
  Future<List<AdModel>> getAllFavoriteAds();
}

class AdsRepository implements IAdsRepository {
  IAdNetworking networking;
  AdsRepository(this.networking);

  List<AdModel> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => AdMapper.fromJson(e)).toList();
  }

  @override
  Future<List<AdModel>> getAllFavoriteAds() async {
    try {
      final response = await networking.getAllFavoriteAds();
      final jsonResponse = Utils.convertToListJson(response);
      final favoriteAds = convertToListModel(jsonResponse);
      return favoriteAds;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AdModel>> getAds() async {
    try {
      final response = await networking.getAds();
      final jsonResponse = Utils.convertToListJson(response);
      final ads = convertToListModel(jsonResponse);
      return ads;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AdModel>> getMyAds() async {
    try {
      final response = await networking.getMyAds();
      final jsonResponse = Utils.convertToListJson(response);
      final ads = convertToListModel(jsonResponse);
      return ads;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AdModel>> getAdsByCategory(int categoryId) async {
    try {
      final response = await networking.getAdsByCategory(categoryId);
      final jsonResponse = Utils.convertToListJson(response);
      final ads = convertToListModel(jsonResponse);
      return ads;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AdModel>> filterAds(AdFilter filter) async {
    try {
      final response = await networking.filterAds(filter.toUrl());
      final jsonResponse = Utils.convertToListJson(response);
      final ads = convertToListModel(jsonResponse);
      return ads;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AdModel>> getAdsByCategoryGroup(int categoryGroupId) async {
    try {
      final response = await networking.getAdsByCategoryGroup(categoryGroupId);

      final jsonResponse = Utils.convertToListJson(response);
      final ads = convertToListModel(jsonResponse);
      return ads;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdModel> createAd(AddAdModel model) async {
    try {
      final response = await networking.createAd(model.toJson());
      final jsonResponse = Utils.convertToJson(response);
      final ad = AdMapper.fromJson(jsonResponse);
      return ad;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeleteAdError?> deleteAd(int adId) async {
    try {
      DeleteAdError? model = await networking.deleteAd(adId);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdModel> showAdDetails(int adId) async {
    try {
      final response = await networking.showAdDetails(adId);
      final jsonResponse = Utils.convertToJson(response);
      final ad = AdMapper.fromJson(jsonResponse);
      return ad;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdModel> updateAd(AdModel model, AddAdModel adModel) async {
    try {
      final response = await networking.updateAd(adModel.toJson(), model.id!);
      final jsonResponse = Utils.convertToJson(response);
      final ad = AdMapper.fromJson(jsonResponse);
      return ad;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdFavoriteModel> favoriteAd(AdFavoriteModel model) async {
    final response =
        await networking.favoriteAd(AdFavoriteMapper.toJson(model));

    final jsonResponse = Utils.convertToJson(response);
    final favoriteAd = AdFavoriteMapper.fromJson(jsonResponse);
    return favoriteAd;
  }

  @override
  Future<void> unFavoriteAd(int adId) async {
    await networking.unFavoriteAd(adId);
  }
}
