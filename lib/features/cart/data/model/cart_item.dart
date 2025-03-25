import 'package:shopping/features/cart/domain/entity/cart_item_entity.dart';
import 'package:shopping/features/products/data/model/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  CartItemEntity toEntity() => CartItemEntity(
        product: product.toEntity(),
        quantity: quantity,
      );
}
