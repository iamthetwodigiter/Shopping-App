import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/cart/presentation/pages/cart_page.dart';
import 'package:shopping/features/cart/provider/cart_provider.dart';

class GoToCartButton extends ConsumerStatefulWidget {
  const GoToCartButton({super.key});

  @override
  ConsumerState<GoToCartButton> createState() => _GoToCartButtonState();
}

class _GoToCartButtonState extends ConsumerState<GoToCartButton> {
  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartNotifierProvider);

    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CartPage();
            }));
          },
          icon: Icon(
            Icons.shopping_cart,
            size: 35,
          ),
        ),
        if (cartState.cartItems.isNotEmpty)
          Positioned(
            right: 10,
            child: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              constraints: BoxConstraints(
                minHeight: 20,
                minWidth: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              child: Text(
                cartState.itemCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
