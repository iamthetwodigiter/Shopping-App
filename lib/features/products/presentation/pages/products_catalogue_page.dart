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
  int _page = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productNotifierProvider.notifier).getAllProducts(_page);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final productState = ref.watch(productNotifierProvider);

    print(_page);
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
            itemCount: 16,
            itemBuilder: (context, index) {
              if (index == 15) {
                return Row(
                  children: [
                    if (_page > 1)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 216, 229),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: Size(50, 25),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                           setState(() {
                          _page--;
                        });
                        ref
                            .read(productNotifierProvider.notifier)
                            .getAllProducts(_page);
                        },
                        child: Text(
                          '< Prev',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 216, 229),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fixedSize: Size(50, 25),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        setState(() {
                          _page++;
                        });
                        ref
                            .read(productNotifierProvider.notifier)
                            .getAllProducts(_page);
                      },
                      child: Text(
                        'Next >',
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
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
              }
            },
          ),
        ),
      ),
    );
  }
}
