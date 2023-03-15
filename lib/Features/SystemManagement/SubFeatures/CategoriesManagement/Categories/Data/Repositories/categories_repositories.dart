import '../../../../../../../App/Utilities/api_handler.dart';
import '../../Domain/Entities/categories_entity.dart';
import '../../Domain/Entities/categories_mapper.dart';
import '../DataSourse/categories_network.dart';

abstract class ICategoriesRepository {
  Future<List<Categories>> getCategories();
  Future<List<Categories>> getMainCategories();
  Future<List<Categories>> getCategoryGroups();
  Future<List<Categories>> getCategoriesPerCategory(int categoryId);
  Future<Categories> addCategory(Categories model);
  Future<Categories> editCategory(Categories model);
  Future<Categories> addCategoryGroup(Categories model);
  Future<Categories> editCategoryGroup(Categories model);
  Future<void> deleteCategory(int id);
  Future<void> deleteCategoryGroup(int id);
}

class CategoriesRepository implements ICategoriesRepository {
  final ICategoriesNetworking categoryNetwork;

  CategoriesRepository(this.categoryNetwork);

  List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from((response));
  }

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  List<Categories> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => CategoriesMapper.fromJson(e)).toList();
  }

  Categories convertToModel(Map<String, dynamic> jsonResponse) {
    return CategoriesMapper.fromJson(jsonResponse);
  }

  @override
  Future<List<Categories>> getCategories() async {
    final response = await categoryNetwork.getCategories();
    final jsonResponse = convertToListJson(response);
    final category = convertToListModel(jsonResponse);
    return category;
  }

  @override
  Future<List<Categories>> getMainCategories() async {
    final response = await categoryNetwork.getMainCategories();
    final jsonResponse = convertToListJson(response);
    final categoroies = convertToListModel(jsonResponse);
    return categoroies;
  }

  @override
  Future<List<Categories>> getCategoryGroups() async {
    final response = await categoryNetwork.getCategoryGroups();
    final jsonResponse = convertToListJson(response);
    final categoroies = convertToListModel(jsonResponse);
    return categoroies;
  }

  @override
  Future<List<Categories>> getCategoriesPerCategory(int categoryId) async {
    final response =
        await categoryNetwork.getCategoriesInCategoryGroup(categoryId);
    final jsonResponse = convertToListJson(response);
    final categoroies = convertToListModel(jsonResponse);
    return categoroies;
  }

  @override
  Future<Categories> addCategory(Categories model) async {
    final response = await categoryNetwork
        .addCategory(CategoriesMapper.toCategoryJson(model));
    final jsonResponse = convertToJson(response);
    final category = convertToModel(jsonResponse);
    return category;
  }

  @override
  Future<Categories> editCategory(Categories model) async {
    final response = await categoryNetwork.editCategory(
        CategoriesMapper.toCategoryJson(model), model.id!);
    final jsonResponse = convertToJson(response);
    final category = convertToModel(jsonResponse);
    return category;
  }

  @override
  Future<Categories> addCategoryGroup(Categories model) async {
    final response = await categoryNetwork
        .addCategoryGroup(CategoriesMapper.toCategoryGroupJson(model));
    final jsonResponse = convertToJson(response);
    final category = convertToModel(jsonResponse);
    return category;
  }

  @override
  Future<Categories> editCategoryGroup(Categories model) async {
    final response = await categoryNetwork.editCategoryGroup(
        CategoriesMapper.toCategoryGroupJson(model), model.id!);
    final jsonResponse = convertToJson(response);
    final category = convertToModel(jsonResponse);
    return category;
  }

  @override
  Future<void> deleteCategory(int id) async {
    try {
      await categoryNetwork.deleteCategory(id);
    } on Exception catch (e) {
      APIHandler.handleExceptions(e);
    }
  }

  @override
  Future<void> deleteCategoryGroup(int id) async {
    try {
      await categoryNetwork.deleteCategoryGroup(id);
    } on Exception catch (e) {
      APIHandler.handleExceptions(e);
    }
  }
}
