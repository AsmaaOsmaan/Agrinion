import 'package:flutter/material.dart';

import '../../Domain/Entities/categories_entity.dart';
import '../../Domain/ServiceLayer/service_layer.dart';

class CategoriesVL extends ChangeNotifier {
  final ICategoriesService _categoriesService;
  CategoriesVL(this._categoriesService);

  List<Categories> categories = [];
  List<Categories> categoryGroups = [];
  List<Categories> categoriesByCategory = [];
  bool isLoading = false;

  restNameArVal() {
    addingCategory?.errors?.nameAr = null;
    notifyListeners();
  }

  resetErrorValue() {
    addingCategory?.errors = null;
  }

  Future<void> getCategories() async {
    isLoading = true;
    categories = await _categoriesService.getCategories();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getCategoryGroups() async {
    isLoading = true;
    categoryGroups = await _categoriesService.getCategoryGroups();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getCategoriesByCategory(int categoryId) async {
    isLoading = true;
    categoriesByCategory =
        await _categoriesService.getCategoriesByCategory(categoryId);
    isLoading = false;
    notifyListeners();
  }

  bool isPublish = false;
  bool isActive = false;
  void addActive(bool active) {
    isActive = active;
    notifyListeners();
  }

  void addPublish(bool published) {
    isPublish = published;
    notifyListeners();
  }

  Color? categoryColor;
  setCategoryColor(Color color) {
    categoryColor = color;
    notifyListeners();
  }

  clearColor() {
    categoryColor = null;
  }

  Categories? selectedCategoryGroup;
  setCategoryGroup(Categories? data) {
    selectedCategoryGroup = data;
    notifyListeners();
  }

  Categories? addingCategory;
  addCategory() async {
    addingCategory = await _categoriesService.addCategory(addingCategory!);
    categories.add(addingCategory!);

    notifyListeners();
  }

  addCategoryGroup() async {
    addingCategory = await _categoriesService.addCategoryGroup(addingCategory!);
    categoryGroups.add(addingCategory!);
    notifyListeners();
  }

  manageAddingCategory(BuildContext context, bool isCategoryGroup) async {
    isCategoryGroup ? await addCategoryGroup() : await addCategory();
    if (addingCategory!.errors == null) {
      addingCategory = null;
      clearColor();
      Navigator.pop(context);
    }
  }

  Future<void> editCategory(Categories category, int index) async {
    final editedCategory = await _categoriesService.editCategory(category);
    categories[index] = editedCategory;
    selectedCategoryGroup = null;
    clearColor();
    notifyListeners();
  }

  Future<void> editCategoryGroup(Categories category, int index) async {
    final editedCategory = await _categoriesService.editCategoryGroup(category);
    categoryGroups[index] = editedCategory;
    clearColor();
    notifyListeners();
  }

  Future<void> deleteCategory(Categories category) async {
    await _categoriesService.deleteCategory(category.id!);
    categories.remove(category);
    notifyListeners();
  }

  Future<void> deleteCategoryGroup(Categories category) async {
    await _categoriesService.deleteCategoryGroup(category.id!);
    categoryGroups.remove(category);
    notifyListeners();
  }
}
