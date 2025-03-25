import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/cart/presentation/widgets/add_to_cart_button.dart';
import 'package:shopping/features/products/domain/entity/product_entity.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final ProductEntity product;
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    RichText customRichText(String title, String subtitle) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: '.toUpperCase(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: subtitle,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    final size = MediaQuery.sizeOf(context);
    final finalPrice = widget.product.price -
        ((widget.product.price * widget.product.discountPercentage) ~/ 100);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.4,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product.images.length,
                        itemBuilder: (context, index) {
                          final image = widget.product.images.elementAt(index);
                          return Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CachedNetworkImage(
                                imageUrl: image,
                                height: size.height * 0.4,
                                width: size.width - 30,
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
                              Text('${index + 1}/${widget.product.images.length}')
                            ],
                          );
                        },
                      ),
                    ),
                    Text(
                      widget.product.title,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      widget.product.brand ?? '',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                final rating = widget.product.rating;
                                if (rating >= index + 1) {
                                  return Icon(Icons.star, color: Colors.amber);
                                } else if (rating > index && rating < index + 1) {
                                  return Icon(Icons.star_half, color: Colors.amber);
                                } else {
                                  return Icon(Icons.star_border,
                                      color: Colors.amber);
                                }
                              },
                            ),
                          ),
                          Text('${widget.product.rating.toString()}/5')
                        ],
                      ),
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Text(
                          '₹${widget.product.price.toString()}',
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '₹${finalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '(${widget.product.discountPercentage}% OFF)',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.product.category.toUpperCase(),
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                widget.product.stock > 0
                                    ? Icons.check_circle
                                    : Icons.remove_circle,
                                color: widget.product.stock > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.product.stock > 0
                                    ? 'In Stock (${widget.product.stock})'
                                    : 'Out of Stock',
                                style: TextStyle(
                                  color: widget.product.stock > 0
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (widget.product.thumbnail.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: widget.product.thumbnail,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator.adaptive(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error, color: Colors.pink),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Brand',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    widget.product.brand ?? 'Unknown Brand',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.pink.shade50),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          Divider(color: Colors.pink.shade50),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: customRichText(
                                'Warranty', widget.product.warrantyInformation),
                          ),
                          Divider(color: Colors.pink.shade50),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: customRichText(
                                'Shipping', widget.product.shippingInformation),
                          ),
                          Divider(color: Colors.pink.shade50),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: customRichText(
                                'Availability', widget.product.availabilityStatus),
                          ),
                          Divider(color: Colors.pink.shade50),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: customRichText(
                                'Return Policy', widget.product.returnPolicy),
                          ),
                          Divider(color: Colors.pink.shade50),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: customRichText(
                              'Minimum order quantity',
                              widget.product.minimumOrderQuantity.toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Reviews',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.product.reviews.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.pink.shade50,
                        height: 32,
                      ),
                      itemBuilder: (context, index) {
                        final review = widget.product.reviews[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.reviewerName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      review.reviewerEmail,
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  review.date.split("T").first,
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  index < review.rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              review.comment,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    if (widget.product.reviews.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'No reviews yet. Be the first to review!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            AddToCartButton(product: widget.product, isDetailsPage: true)
          ],
        ),
      ),
    );
  }
}
