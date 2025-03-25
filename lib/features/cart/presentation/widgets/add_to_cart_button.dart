import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/cart/domain/entity/cart_item_entity.dart';
import 'package:shopping/features/cart/provider/cart_provider.dart';
import 'package:shopping/features/products/domain/entity/product_entity.dart';

class AddToCartButton extends ConsumerWidget {
  final ProductEntity product;
  final bool isDetailsPage;
  const AddToCartButton({
    super.key,
    required this.product,
    this.isDetailsPage = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final cartState = ref.watch(cartNotifierProvider);
    final cartItem = cartState.cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItemEntity(product: product, quantity: 0),
    );

    void showMinOrderQuantityError(BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Minimum order quantity is ${product.minimumOrderQuantity}',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (cartItem.quantity == 0) {
      return ElevatedButton(
        onPressed: () {
          ref.read(cartNotifierProvider.notifier).addToCart(
                CartItemEntity(
                  product: product,
                  quantity: product.minimumOrderQuantity.toInt(),
                ),
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
          fixedSize: isDetailsPage ? Size(size.width - 55, 35) : Size(80, 35),
        ),
        child: Text(
          isDetailsPage ? 'Add to Cart' : 'Add',
          style: TextStyle(
            color: Colors.pink,
          ),
        ),
      );
    }

    return Container(
      height: isDetailsPage ? 50 : 42,
      width: isDetailsPage ? size.width - 55 : 125,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.pink, width: 0.5),
      ),
      alignment: Alignment.center,
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
              if (cartItem.quantity - 1 >= product.minimumOrderQuantity) {
                ref.read(cartNotifierProvider.notifier).updateQuantity(
                      product.id,
                      cartItem.quantity - 1,
                    );
              } else {
                showMinOrderQuantityError(context);
              }
            },
          ),
          Text(
            isDetailsPage
                ? '${cartItem.quantity} items added to cart'
                : '${cartItem.quantity}',
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
              if (cartItem.quantity + 1 <= product.stock) {
                ref.read(cartNotifierProvider.notifier).updateQuantity(
                      product.id,
                      cartItem.quantity + 1,
                    );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Maximum stock limit reached'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
