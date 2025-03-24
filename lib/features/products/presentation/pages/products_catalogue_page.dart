import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/products/presentation/widgets/products_card.dart';
import 'package:shopping/features/products/provider/product_provider.dart';

class ProductsCataloguePage extends ConsumerStatefulWidget {
  const ProductsCataloguePage({super.key});

  @override
  ConsumerState<ProductsCataloguePage> createState() =>
      _ProductsCataloguePageState();
}

class _ProductsCataloguePageState extends ConsumerState<ProductsCataloguePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productNotifierProvider.notifier).getAllProducts(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final productState = ref.watch(productNotifierProvider);

    if (productState.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Catalogue'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                final product1 =
                    productState.productsList!.elementAt(index * 2);
                final product2 =
                    productState.productsList!.elementAt(index * 2 + 1);
                return Row(
                  children: [
                    ProductsCard(
                      product: product1,
                    ),
                    ProductsCard(
                      product: product2,
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
