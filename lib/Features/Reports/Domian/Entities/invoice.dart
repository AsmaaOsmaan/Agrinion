import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';

class InvoicesModel {
  List<int>? conversationsIds;
  String? supplyDate;
  int? invoiceId;
  int? creatorId;
  String? discount;
  bool? taxable;
  List<Sales>? sales;
  CommercialProfileModel? client;
  CommercialProfileModel? supplier;
  int? id;
  double? total;
  double? taxRate;
  double? totalAfterTax;
  double? totalTaxAmount;
  double? remainingTotal;
  String? createdAt;
  String? invoiceNumber;
  int? paymentMethodIndex;
  String? paymentMethod;

  InvoicesModel(
      {this.conversationsIds,
      this.supplyDate,
      this.paymentMethod,
      this.paymentMethodIndex,
      this.invoiceId,
      this.discount,
      this.taxable,
      this.sales,
      this.id,
      this.totalTaxAmount,
      this.totalAfterTax,
      this.client,
      this.remainingTotal,
      this.createdAt,
      this.invoiceNumber,
      this.taxRate,
      this.total,
      this.supplier,
      this.creatorId});
}



class Sales {
  int? id;
  double? totalPrice;
  double? quantity;
  Product? product;
  UnitType? productUnitType;
  double? unitPrice;
  Sales({
    this.id,
    this.totalPrice,
    this.quantity,
    this.product,
    this.productUnitType,
    this.unitPrice,
  });
}
