import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/products/data/repository/product_repository_impl.dart';
import 'package:shopping/features/products/data/service/product_service.dart';
import 'package:shopping/features/products/domain/repository/product_repository.dart';
import 'package:shopping/features/products/presentation/notifier/product_notifier.dart';

final productServiceProvider =
    Provider<ProductService>((ref) => ProductService());

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final productService = ref.read(productServiceProvider);
  return ProductRepositoryImpl(productService);
});

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return ProductNotifier(productRepository);
});
