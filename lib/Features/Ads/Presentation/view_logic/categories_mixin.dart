import '../../../SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import '../../Domain/BusinessLogic/service_layer.dart';

mixin CategoriesMixin {
  List<Categories> categories = [];
  List<Categories> subCategories = [];
  Categories? category;

  bool isCategoryLoading = false;

  setAllCategoriesWithFalse() {
    for (var x in categories) {
      x.isSelected = false;
    }
  }

  setSubCategory(int index) {
    category = subCategories[index];
    setAllCategoriesWithFalse();
    subCategories[index].isSelected = true;
  }

  setAllSubCategoriesWithFalse() {
    for (var x in subCategories) {
      x.isSelected = false;
    }
  }

  getCategoriesFromMixin(IAdService _service) async {
    isCategoryLoading = true;
    categories = await _service.getCategories();
    isCategoryLoading = false;
  }
}
