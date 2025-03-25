import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping/features/cart/domain/entity/cart_item_entity.dart';
import 'package:shopping/features/cart/domain/repository/cart_item_repository.dart';

class CartItemRepositoryImpl implements CartItemRepository {
  final Box _cartBox;

  CartItemRepositoryImpl(this._cartBox);

@override
  Future<void> addToCart(CartItemEntity item) async {
    await _cartBox.put(item.product.id, item.toMap());
  }

  @override
  Future<void> removeFromCart(int id) async {
    await _cartBox.delete(id);
  }

  @override
  Future<void> updateQuantity(int id, int quantity) async {
    final item = await _getCartItem(id);
    if (item != null) {
      final updatedItem = item.copyWith(quantity: quantity);
      await _cartBox.put(id, updatedItem.toMap());
    }
  }

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    return _cartBox.values
        .map((item) => CartItemEntity.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }

  @override
  Future<void> clearCart() async {
    await _cartBox.clear();
  }

  Future<CartItemEntity?> _getCartItem(int id) async {
    final data = _cartBox.get(id);
    if (data != null) {
      return CartItemEntity.fromMap(Map<String, dynamic>.from(data));
    }
    return null;
  }
}
