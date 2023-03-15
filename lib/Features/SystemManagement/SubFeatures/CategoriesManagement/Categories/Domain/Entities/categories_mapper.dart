import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_errors.dart';

import 'categories_entity.dart';

class CategoriesMapper {
  static Categories fromJson(Map<String, dynamic> json) {
    try {
      return Categories(
        id: json['id'],
        name: json['name_ar'],
        nameEn: json['name_en'],
        isActive: json['active'] ?? false,
        isPublished: json['published'] ?? false,
        subCategoryCount: json['sub_category_count'],
        isCategoryGroup: json['sub_category_count'] != null
            ? json['sub_category_count'] > 0
            : false,
        type: json['type'],
        color: json['color']?.toString().toColor(),
        errors: json['errors'] != null ? CategoriesError.fromJson(json) : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toCategoryJson(Categories category) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = category.name;
    data['name_en'] = category.nameEn;
    data['active'] = category.isActive;
    data['published'] = category.isPublished;
    data['category_group_id'] = category.categoryGroupId;
    data['color'] = category.color != null ? category.color!.toHex() : null;
    return {"category": data};
  }

  static Map<String, dynamic> toCategoryGroupJson(Categories category) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = category.name;
    data['name_en'] = category.nameEn;
    data['active'] = category.isActive;
    data['published'] = category.isPublished;
    data['color'] = category.color != null ? category.color!.toHex() : null;
    return {"category_group": data};
  }
}
