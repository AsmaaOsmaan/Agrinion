import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Domain/Entities/broker_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';

import '../../../Orders/Domain/Entities/create_order_model.dart';
import '../../../SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';

class AdModel {
  int? id;
  double? price;
  bool negotiable;
  int? quantity;
  double? unitWeight;
  int? minimalOfferableQuantity;
  String? notes;
  Cities? city;
  Market? market;
  String? image;
  Categories? category;
  Product product;
  UnitType? unitType;
  int? remainingQty;
  Broker ? broker;
  CommercialProfileModel? commercialProfile;
  String? carNumber;
  String? carPlate;
  bool? isFav;
  Creator? creator;
  List<int>? negotiatorIds;

  AdModel({
    this.id,
    this.price,
    this.negotiable = true,
    this.quantity,
    this.unitWeight,
    this.minimalOfferableQuantity,
    this.notes,
    this.city,
    this.market,
    this.category,
    required this.product,
    required this.unitType,
    this.image,
    this.remainingQty,
    this.broker,
    this.commercialProfile,
    this.carNumber,
    this.carPlate,
    this.isFav,
    this.creator,
    this.negotiatorIds,
  });
}
