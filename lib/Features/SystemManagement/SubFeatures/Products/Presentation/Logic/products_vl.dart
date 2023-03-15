import 'dart:io';

import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/ServiceLayer/service_layer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../App/Resources/color_manager.dart';
import '../../../../../../App/Resources/text_themes.dart';
import '../../../../../../App/Utilities/api_handler.dart';
import '../../../../../../App/Utilities/size_config.dart';
import '../../../../../../App/Utilities/utils.dart';
import '../../../../../../generated/translations.g.dart';

class ProductsVL extends ChangeNotifier {
  final IProductsService _productsService;
  ProductsVL(this._productsService);

  List<Product> products = [];
  getProducts() async {
    products = await _productsService.getProducts();
    notifyListeners();
  }

  bool priceable = false;
  changeproductStatus(bool val) {
    priceable = val;
    notifyListeners();
  }

  Product? addingProduct;
  addProduct() async {
    addingProduct = await _productsService.addProduct(addingProduct!);

    notifyListeners();
  }

  manageAddingProduct(BuildContext context) async {
    await addProduct();
    if (addingProduct!.errors == null) {
      products.add(addingProduct!);
      category = null;
      image = null;
      Navigator.pop(context);
    }
  }

  editProduct(Product product, int index) async {
    final editedProduct = await _productsService.editProduct(product);
    products[index] = editedProduct;
    notifyListeners();
  }

  deleteProduct(Product product) async {
    try {
      await _productsService.deleteProduct(product.id!);
      products.remove(product);
    } on Exception catch (e) {
      APIHandler.handleExceptions(e);
    }
    notifyListeners();
  }

  Categories? category;

  void setCategory(Categories? newCategory) {
    category = newCategory;
    notifyListeners();
  }

  File? image;
  void setProductImage() async {
    image = await Utils.getImage();
    notifyListeners();
  }

  Widget getProductImage([String? photo]) {
    if (image != null) {
      return Image.file(
        image!,
        fit: BoxFit.cover,
        height: 50,
        width: SizeConfig.screenWidth,
      );
    }
    if (photo != null) {
      return Image.network(
        photo,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.camera_alt_outlined,
            color: ColorManager.grey,
            size: 28,
          ),
          const SizedBox(height: 10),
          Text(
            tr(LocaleKeys.upload_photos),
            style: getRegularStyle(
              fontSize: 16,
              fontColor: ColorManager.grey,
            ),
          ),
        ],
      ),
    );
  }
}
