import '../../../../../../App/Utilities/utils.dart';
import '../../Domain/Entities/products_entity.dart';
import '../../Domain/Entities/products_mapper.dart';
import '../DataSourse/products_network.dart';

abstract class IProductsRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> getProductsPerCategoryId(int categoryId);
  Future<Product> addProduct(Product model);
  Future<Product> editProduct(Product model);
  Future<void> deleteProduct(int id);
}

class ProductsRepository implements IProductsRepository {
  final IProductsNetworking productsNetwork;

  ProductsRepository(this.productsNetwork);
  List<Product> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse
        .map((e) => ProductsMapper.fromManagementJson(e))
        .toList();
  }

  Product convertToModel(Map<String, dynamic> jsonResponse) {
    return ProductsMapper.fromManagementJson(jsonResponse);
  }

  @override
  Future<List<Product>> getProducts() async {
    final response = await productsNetwork.getProducts();
    final jsonResponse = Utils.convertToListJson(response);
    final products = convertToListModel(jsonResponse);
    return products;
  }

  @override
  Future<List<Product>> getProductsPerCategoryId(int categoryId) async {
    final response = await productsNetwork.getProductsPerCategory(categoryId);
    final jsonResponse = Utils.convertToListJson(response);
    final products = convertToListModel(jsonResponse);
    return products;
  }

  @override
  Future<Product> addProduct(Product model) async {
    final response =
        await productsNetwork.addProduct(ProductsMapper.toJson(model));
    final jsonResponse = Utils.convertToJson(response);
    final product = convertToModel(jsonResponse);
    return product;
  }

  @override
  Future<Product> editProduct(Product model) async {
    final response = await productsNetwork.editProduct(
        ProductsMapper.toJson(model), model.id!);
    final jsonResponse = Utils.convertToJson(response);
    final product = convertToModel(jsonResponse);
    return product;
  }

  @override
  Future<void> deleteProduct(int id) async {
    await productsNetwork.deleteProduct(id);
  }
}
