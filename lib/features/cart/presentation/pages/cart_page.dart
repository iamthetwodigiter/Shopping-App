import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/cart/domain/entity/cart_item_entity.dart';
import 'package:shopping/features/cart/presentation/widgets/add_to_cart_button.dart';
import 'package:shopping/features/products/domain/entity/product_entity.dart';
import 'package:shopping/features/products/presentation/widgets/recommended_items.dart';
import 'package:shopping/features/cart/provider/cart_provider.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  num finalPrice(num price, num discountPercentage) {
    return price - ((price * discountPercentage) ~/ 100);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cartState = ref.watch(cartNotifierProvider);

    num totalAmont() {
      num total = 0;
      for (var cartItem in cartState.cartItems) {
        total += (finalPrice(
                cartItem.product.price, cartItem.product.discountPercentage) *
            cartItem.quantity);
      }
      return total;
    }

    int totalItems() {
      int totalitems = 0;
      for (var cartItem in cartState.cartItems) {
        totalitems += cartItem.quantity;
      }
      return totalitems;
    }

    num getItemsTotal(ProductEntity product) {
      final cartItem = cartState.cartItems.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => CartItemEntity(product: product, quantity: 0),
      );

      return finalPrice(product.price, product.discountPercentage) *
          cartItem.quantity;
    }

    void clearCart(BuildContext context, VoidCallback deleteFn) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Clear Cart',
              style:
                  TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
          content: Text(
              'Following items will be removed:\n\n* ${cartState.cartItems.map((item) => item.product.title).join("\n* ")}'),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Text(
                'NO',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                deleteFn();
                Navigator.of(context).pop();
              },
              icon: Text(
                'YES',
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        actions: [
          if (cartState.itemCount > 0)
            IconButton(
              onPressed: () {
                clearCart(context, () {
                  ref.read(cartNotifierProvider.notifier).clearCart();
                });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.pink,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: cartState.itemCount == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            'Nothing in the cart 😓\nGo add something',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Text(
                            'Items you might like',
                            style: TextStyle(fontSize: 18),
                          ),
                          RecommendedItems(),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartState.itemCount,
                      itemBuilder: (context, index) {
                        final cartItem =
                            cartState.cartItems.elementAt(index).product;
                        return Container(
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: cartItem.images.last,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.pink,
                                    ),
                                  );
                                },
                                placeholder: (context, url) {
                                  return Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                },
                              ),
                              SizedBox(
                                width: size.width - 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      cartItem.brand ?? '',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Row(
                                      spacing: 8,
                                      children: [
                                        Text(
                                          '₹${cartItem.price.toString()}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          '₹${finalPrice(cartItem.price, cartItem.discountPercentage).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${cartItem.discountPercentage}% OFF',
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(getItemsTotal(cartItem)
                                        .toStringAsFixed(2)),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: AddToCartButton(product: cartItem),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
            if (cartState.itemCount != 0)
              Container(
                height: 120,
                width: size.width,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹${totalAmont().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
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
                      onPressed: () {
                        ref.read(cartNotifierProvider.notifier).clearCart();
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Order placed successfully,',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Check Out (${totalItems()})',
                        style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
