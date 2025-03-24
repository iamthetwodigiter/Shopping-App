import 'package:shopping/features/products/data/model/product.dart';
import 'package:shopping/features/products/data/service/product_service.dart';
import 'package:shopping/features/products/domain/entity/product_entity.dart';
import 'package:shopping/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService _productService;

  ProductRepositoryImpl(this._productService);
  @override
  Future<List<ProductEntity>> getAllProducts(int page) async {
    try {
      final response = await _productService.getAllProducts(page);
      final List<Product> products =
          response.map((product) => Product.fromMap(product)).toList();
      final productEntity =
          products.map((product) => product.toEntity()).toList();
      return productEntity;
    } catch (e) {
      rethrow;
    }
  }
}
