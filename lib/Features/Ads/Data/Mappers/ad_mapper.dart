import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/cities_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/mappers/broker_mapper.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../App/Resources/assets_manager.dart';
import '../../../Orders/Data/Mappers/create_order_mapper.dart';
import '../../../SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Data/Mappers/commercial_profile_mapper.dart';
import '../../Domain/Models/ad_model.dart';

class AdMapper {
  static AdModel fromJson(Map<String, dynamic> json) {
    List<int> negotiatorsIds = [];

    if (json['negotiator_ids'] != null) {
      json['negotiator_ids'].forEach((v) {
        negotiatorsIds.add(v.toInt());
      });
    }
    return AdModel(
      id: json['id'],
      price: json['price'],
      isFav: json['favorited'],
      negotiable: json['negotiable'] ?? true,
      quantity: json['quantity'],
      unitWeight: json['unit_weight'],
      remainingQty: json['remaining_quantity'],
      image: json['image'] != null
          ? NetworkHelper.apiBaseUrl! + json['image']
          : AppImages.dummyImage,
      minimalOfferableQuantity: json['minimal_offerable_quantity'] ?? 1,
      notes: json['notes'],
      city: json['city'] != null ? CitiesMapper.fromJson(json['city']) : null,
      market: json['market'] != null
          ? MarketsMapper.fromJson(json['market'])
          : null,
      category: json['category'] != null
          ? CategoriesMapper.fromJson(json['category'])
          : null,
      product: ProductsMapper.fromJson(json['product']),
      unitType: json['unit_type'] == null
          ? null
          : UnitTypeMapper.fromJson(json['unit_type']),
      broker: json['broker'] == null
          ? null
          : BrokersMapper.fromJson(json['broker']),
      commercialProfile: json['commercial_profile'] == null
          ? null
          : CommercialProfileMapper.fromJson(json['commercial_profile']),
      carNumber: json['car_number'] ?? tr(LocaleKeys.no_data_found),
      carPlate: json['car_plate_number'] ?? tr(LocaleKeys.no_data_found),
      creator: json['creator'] != null
          ? CreatorMapper.fromJson(json['creator'])
          : null,
      negotiatorIds: negotiatorsIds,
    );
  }
}
