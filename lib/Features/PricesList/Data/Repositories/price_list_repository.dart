import 'package:agriunion/Features/PricesList/Data/Mappers/price_item_mapper.dart';
import 'package:agriunion/Features/PricesList/Data/Mappers/price_list_mapper.dart';
import 'package:agriunion/Features/PricesList/Data/Networking/price_list_networking.dart';
import 'package:agriunion/Features/PricesList/Domain/Models/price_item_model.dart';

import '../../../../App/Utilities/utils.dart';
import '../../Domain/Models/price_list_model.dart';

abstract class IPriceListRepo {
  Future<PriceListModel> getPriceList(PriceListModel model);
  Future<PriceItemModel?> updatePriceList(PriceItemModel model);
  Future<PriceItemModel?> createPriceList(PriceItemModel model);
  Future<void> deletePriceList(int pricedItemId);
}

class PriceListRepo implements IPriceListRepo {
  final IPriceListNetworking _networking;
  PriceListRepo(this._networking);

  PriceListModel convertToModel(Map<String, dynamic> json) {
    return PriceListMapper.fromJson(json);
  }

  @override
  Future<PriceListModel> getPriceList(PriceListModel model) async {
    try {
      final response = await _networking.getPriceList(model.toUrl());
      final jsonResponse = Utils.convertToJson(response);
      final priceList = convertToModel(jsonResponse);
      return priceList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PriceItemModel?> createPriceList(PriceItemModel model) async {
    try {
      final response =
          await _networking.createPriceList(PriceItemMapper.toJson(model));
      final jsonResponse = Utils.convertToJson(response);
      final priceItem = PriceItemMapper.fromJson(jsonResponse);
      return priceItem;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PriceItemModel?> updatePriceList(PriceItemModel model) async {
    try {
      final response = await _networking.updatePriceList(
          PriceItemMapper.toJson(model), model.id!);
      final jsonResponse = Utils.convertToJson(response);
      final priceItem = PriceItemMapper.fromJson(jsonResponse);
      return priceItem;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePriceList(int pricedItemId) async {
    try {
      await _networking.deletePriceList(pricedItemId);
    } on Exception {
      rethrow;
    }
  }
}
