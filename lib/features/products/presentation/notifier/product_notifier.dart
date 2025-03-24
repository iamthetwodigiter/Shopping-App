// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping/features/products/domain/entity/product_entity.dart';
import 'package:shopping/features/products/domain/repository/product_repository.dart';

class ProductState {
  final bool isLoading;
  final List<ProductEntity>? productsList;
  final String? error;

  ProductState({
    this.isLoading = false,
    this.productsList,
    this.error,
  });

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? productsList,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      productsList: productsList ?? this.productsList,
      error: error ?? this.error,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductRepository _productRepository;
  ProductNotifier(this._productRepository) : super(ProductState());

  Future<void> getAllProducts(int page) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _productRepository.getAllProducts(page);
      state = state.copyWith(isLoading: false, productsList: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
