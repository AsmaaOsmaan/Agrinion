import 'package:agriunion/Features/Reports/Domian/Entities/invoice.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Data/Mappers/commercial_profile_mapper.dart';

class InvoicesMapper {
  static InvoicesModel fromJson(Map<String, dynamic> json) {
    return InvoicesModel(
        invoiceId: json['id'],
        taxable: json["taxable"],
        discount: json["discount"].toString(),
        createdAt: json["created_at"],
        supplyDate: json["supply_date"],
        invoiceNumber: json["invoice_number"],
        id: json["id"],
        taxRate: json["tax_rate"],
        totalAfterTax: json["grand_total"],
        total: json["total"],
        totalTaxAmount: json["total_tax_amount"],
        client: json['client']!=null?CommercialProfileMapper.fromJson(json['client']):null,
        supplier:json['supplier']!=null? CommercialProfileMapper.fromJson(json['supplier']):null,
        sales:json['sales']!=null ?fillSalesList(json['sales']):null,
        paymentMethod: json["payment_method"],
        remainingTotal: json["remaining_total"],
        creatorId: json["creator_id"]);
  }

  static List<Sales>? fillSalesList(List<dynamic>? json) {
    if (json == null) return null;
    return json.map((e) => SalesMapper.fromJson(e)).toList();
  }

  static Map<String, dynamic> toMap(InvoicesModel model) {
    final result = <String, dynamic>{};

    result.addAll({'conversation_ids': model.conversationsIds});
    result.addAll({'supply_date': model.supplyDate});
    result.addAll({'taxable': model.taxable});
    model.discount != null && model.discount!.isNotEmpty
        ? result.addAll({'discount': double.parse(model.discount!)})
        : null;
    result.addAll({'payment_method': model.paymentMethodIndex});

    return {"invoice": result};
  }
}

class SalesMapper {
  static Sales fromJson(Map<String, dynamic> json) {
    return Sales(
      quantity: json["quantity"],
      product: (json["product"] != null)
          ? ProductsMapper.fromManagementJson(json['product'])
          : null,
      id: json["id"],
      totalPrice: json['total_price'],
      unitPrice: json['price_item'] ,
      productUnitType: UnitTypeMapper.fromJson(json['product_unit_type']),
    );
  }
}
