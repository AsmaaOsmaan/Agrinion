import 'dart:io';

import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_errors.dart';

class Product {
  int? id;
  String nameAr;
  String nameEn;
  int? categoryId;
  File? uploadImage;
  String? image;
  ProductsError? errors;
  bool isSelected;
  bool? priceable;

  Product({
    this.id,
    required this.nameAr,
    required this.nameEn,
    this.categoryId,
    this.uploadImage,
    this.image,
    this.errors,
    this.isSelected = false,
    this.priceable,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
