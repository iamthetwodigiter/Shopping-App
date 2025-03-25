import 'package:shopping/features/cart/domain/entity/cart_item_entity.dart';

abstract class CartItemRepository {
  Future<void> addToCart(CartItemEntity item);
  Future<void> removeFromCart(int id);
  Future<void> updateQuantity(int id, int quantity);
  Future<List<CartItemEntity>> getCartItems();
  Future<void> clearCart();
}
