import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_errors.dart';

import '../../../../../../App/Network/network_helper.dart';
import 'products_entity.dart';

class ProductsMapper {
  static Product fromManagementJson(Map<String, dynamic> json) {
   try {
      return Product(
        id: json['id'],
        nameAr: json['name_ar'],
        nameEn: json['name_en'],
        categoryId:json['category']!=null? json['category']['id']:null,
        image: json['image'] != null
            ? NetworkHelper.apiBaseUrl! + json['image']
            : null,
        errors: json['errors'] != null ? ProductsError.fromJson(json) : null,
        priceable: json['priceable'] ?? false,
      );
   }
    catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Product fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['product_id'],
        nameAr: json['name_ar'],
        nameEn: json['name_en'],
        errors: json['errors'] != null ? ProductsError.fromJson(json) : null,
        priceable: json['priceable'] ?? false,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toJson(Product products) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = products.nameAr;
    data['name_en'] = products.nameEn;
    data['category_id'] = products.categoryId;
    data['product_image'] = products.uploadImage;
    data['priceable'] = products.priceable;
    return data;
  }
}
