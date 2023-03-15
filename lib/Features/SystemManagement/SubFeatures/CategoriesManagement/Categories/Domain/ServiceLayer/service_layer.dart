import 'package:agriunion/App/Utilities/api_handler.dart';

import '../../Data/Repositories/categories_repositories.dart';
import '../Entities/categories_entity.dart';

abstract class ICategoriesService {
  Future<List<Categories>> getCategories();
  Future<List<Categories>> getMainCategories();
  Future<List<Categories>> getCategoryGroups();
  Future<List<Categories>> getCategoriesByCategory(int categoryId);
  Future<Categories> addCategory(Categories category);
  Future<Categories> editCategory(Categories category);
  Future<Categories> addCategoryGroup(Categories category);
  Future<Categories> editCategoryGroup(Categories category);
  Future<void> deleteCategory(int id);
  Future<void> deleteCategoryGroup(int id);
}

class CategoriesService implements ICategoriesService {
  final ICategoriesRepository categoriesRepo;
  CategoriesService(this.categoriesRepo);

  @override
  Future<List<Categories>> getCategories() async {
    return await categoriesRepo.getCategories();
  }

  @override
  Future<List<Categories>> getMainCategories() async {
    return await categoriesRepo.getMainCategories();
  }

  @override
  Future<List<Categories>> getCategoryGroups() async {
    return await categoriesRepo.getCategoryGroups();
  }

  @override
  Future<List<Categories>> getCategoriesByCategory(int categoryId) async {
    return await categoriesRepo.getCategoriesPerCategory(categoryId);
  }

  @override
  Future<Categories> addCategory(Categories category) async {
    return await categoriesRepo.addCategory(category);
  }

  @override
  Future<Categories> editCategory(Categories category) async {
    return await categoriesRepo.editCategory(category);
  }

  @override
  Future<Categories> addCategoryGroup(Categories category) async {
    return await categoriesRepo.addCategoryGroup(category);
  }

  @override
  Future<Categories> editCategoryGroup(Categories category) async {
    return await categoriesRepo.editCategoryGroup(category);
  }

  @override
  Future<void> deleteCategory(int id) async {
    try {
      await categoriesRepo.deleteCategory(id);
    } on Exception catch (e) {
      APIHandler.handleExceptions(e);
    }
  }

  @override
  Future<void> deleteCategoryGroup(int id) async {
    try {
      await categoriesRepo.deleteCategoryGroup(id);
    } on Exception catch (e) {
      APIHandler.handleExceptions(e);
    }
  }
}
