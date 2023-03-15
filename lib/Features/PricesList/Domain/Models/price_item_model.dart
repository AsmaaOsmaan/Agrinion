import '../../../SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import '../../../SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';

class PriceItemModel {
  int? id;
  double? minPrice;
  double? maxPrice;
  Product? product;
  UnitType? unitType;
  int? marketId;
  int? priceListId;
  double? weight;

  PriceItemModel({
    this.id,
    this.minPrice,
    this.maxPrice,
    this.product,
    this.unitType,
    this.marketId,
    this.priceListId,
    this.weight,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceItemModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          minPrice == other.minPrice &&
          maxPrice == other.maxPrice &&
          product == other.product &&
          unitType == other.unitType;

  @override
  int get hashCode => id.hashCode;
}
