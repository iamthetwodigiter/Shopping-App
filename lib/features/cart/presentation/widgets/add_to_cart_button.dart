import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/cart/domain/entity/cart_item_entity.dart';
import 'package:shopping/features/cart/provider/cart_provider.dart';
import 'package:shopping/features/products/domain/entity/product_entity.dart';

class AddToCartButton extends ConsumerWidget {
  final ProductEntity product;

  const AddToCartButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final cartItem = cartState.cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItemEntity(product: product, quantity: 0),
    );
    if (cartItem.quantity == 0) {
      return ElevatedButton(
        onPressed: () {
          ref.read(cartNotifierProvider.notifier).addToCart(
                CartItemEntity(product: product, quantity: 1),
              );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: BorderSide(
            color: Colors.pink,
            width: 0.5,
          ),
        ),
        child: const Text(
          'Add',
          style: TextStyle(
            color: Colors.pink,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.pink, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.remove,
              color: Colors.pink,
            ),
            onPressed: () {
              ref.read(cartNotifierProvider.notifier).updateQuantity(
                    product.id,
                    cartItem.quantity - 1,
                  );
            },
          ),
          Text(
            '${cartItem.quantity}',
            style: TextStyle(
              color: Colors.pink,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.add,
              color: Colors.pink,
            ),
            onPressed: () {
              ref.read(cartNotifierProvider.notifier).updateQuantity(
                    product.id,
                    cartItem.quantity + 1,
                  );
            },
          ),
        ],
      ),
    );
  }
}
