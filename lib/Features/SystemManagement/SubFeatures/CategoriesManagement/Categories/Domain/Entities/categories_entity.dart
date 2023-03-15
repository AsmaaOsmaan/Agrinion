import 'dart:ui';

import 'categories_errors.dart';

class Categories {
  int? id;
  String name;
  String? nameEn;
  bool isActive;
  bool isPublished;
  String? type;
  int? subCategoryCount;
  bool isSelected;
  bool isCategoryGroup;
  Color? color;
  int? categoryGroupId;

  CategoriesError? errors;
  Categories({
    this.id,
    required this.name,
    this.nameEn,
    required this.isActive,
    required this.isPublished,
    this.subCategoryCount,
    this.type,
    this.isSelected = false,
    this.color,
    this.isCategoryGroup = false,
    this.errors,
    this.categoryGroupId,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Categories &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameEn == other.nameEn &&
          name == other.name;

  @override
  int get hashCode => id.hashCode;
}
