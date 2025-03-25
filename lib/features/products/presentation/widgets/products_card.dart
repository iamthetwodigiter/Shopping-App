import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/features/products/domain/entity/product_entity.dart';

class ProductsCard extends StatefulWidget {
  final ProductEntity product;
  const ProductsCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final finalPrice = widget.product.price -
        ((widget.product.price * widget.product.discountPercentage) ~/ 100);
    return Container(
      height: 260,
      width: size.width / 2.2,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.thumbnail,
                height: 150,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: Size(50, 25),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.product.title,
            style: TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.product.brand ?? '',
            style: TextStyle(fontSize: 12),
          ),
          Spacer(),
          Row(
            spacing: 8,
            children: [
              Text(
                '₹${widget.product.price.toString()}',
                style: TextStyle(
                  fontSize: 10,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                '₹${finalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            '${widget.product.discountPercentage}% OFF',
            style: TextStyle(
              color: Colors.pink,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
