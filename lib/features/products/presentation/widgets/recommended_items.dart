import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/products/domain/entity/product_entity.dart';
import 'package:shopping/features/products/presentation/widgets/products_card.dart';
import 'package:shopping/features/products/provider/product_provider.dart';

class RecommendedItems extends ConsumerWidget {
  const RecommendedItems({super.key});

  List<ProductEntity> getRandomProducts(List<ProductEntity> allProducts) {
    if (allProducts.isEmpty) return [];
    
    final random = Random();
    final List<ProductEntity> randomProducts = [];
    final Set<int> usedIndices = {};

    while (randomProducts.length < 15 && usedIndices.length < allProducts.length) {
      final randomIndex = random.nextInt(allProducts.length);
      if (!usedIndices.contains(randomIndex)) {
        usedIndices.add(randomIndex);
        randomProducts.add(allProducts[randomIndex]);
      }
    }

    return randomProducts;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final productsState = ref.watch(productNotifierProvider);
    final randomProducts = getRandomProducts(productsState.productsList!);

    return Container(
      height: 265,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: randomProducts.length,
        itemBuilder: (context, index) {
          return ProductsCard(product: randomProducts[index]);
        },
      ),
    );
  }
}