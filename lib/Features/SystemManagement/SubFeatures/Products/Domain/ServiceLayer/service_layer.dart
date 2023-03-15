import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';

import '../../../../../../App/Errors/exceptions.dart';
import '../../Data/Repositories/products_repo_impl.dart';

abstract class IProductsService {
  Future<List<Product>> getProducts();
  Future<Product> addProduct(Product product);
  Future<Product> editProduct(Product product);
  Future<void> deleteProduct(int id);
}

class ProductsService implements IProductsService {
  final IProductsRepository productsRepo;
  ProductsService(this.productsRepo);

  @override
  Future<List<Product>> getProducts() async {
    return await productsRepo.getProducts();
  }

  @override
  Future<Product> addProduct(Product product) async {
    return await productsRepo.addProduct(product);
  }

  @override
  Future<Product> editProduct(Product product) async {
    return await productsRepo.editProduct(product);
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      await productsRepo.deleteProduct(id);
    } on Exception {
      throw const BadEntitesException(message: "This Data has associated Ads");
    }
  }
}
