import 'package:shopping/features/products/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getAllProducts(int page);
}
