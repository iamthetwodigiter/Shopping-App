import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/cart/domain/entity/cart_item_entity.dart';
import 'package:shopping/features/cart/domain/repository/cart_item_repository.dart';

class CartState {
  final bool isLoading;
  final List<CartItemEntity> cartItems;
  final String? error;

  CartState({
    this.isLoading = false,
    this.cartItems = const [],
    this.error,
  });

  CartState copyWith({
    bool? isLoading,
    List<CartItemEntity>? cartItems,
    String? error,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cartItems: cartItems ?? this.cartItems,
      error: error ?? this.error,
    );
  }

  int get itemCount => cartItems.length;
}

class CartNotifier extends StateNotifier<CartState> {
  final CartItemRepository _cartItemRepository;

  CartNotifier(this._cartItemRepository) : super(CartState()) {
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    state = state.copyWith(isLoading: true);
    try {
      final items = await _cartItemRepository.getCartItems();
      state = state.copyWith(cartItems: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> addToCart(CartItemEntity item) async {
    try {
      await _cartItemRepository.addToCart(item);
      await loadCartItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> removeFromCart(int id) async {
    try {
      await _cartItemRepository.removeFromCart(id);
      await loadCartItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateQuantity(int id, int quantity) async {
    try {
      if (quantity == 0) {
        await removeFromCart(id);
      }
      await _cartItemRepository.updateQuantity(id, quantity);

      await loadCartItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartItemRepository.clearCart();
      await loadCartItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
