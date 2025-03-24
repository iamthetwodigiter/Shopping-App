import 'package:shopping/features/products/data/model/meta.dart';
import 'package:shopping/features/products/data/model/review.dart';
import 'package:shopping/features/products/domain/entity/product_entity.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final num price;
  final num discountPercentage;
  final num rating;
  final num stock;
  final List<String> tags;
  final String? brand;
  final String sku;
  final num weight;
  final Map<String, num> dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final num minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.tags,
      required this.brand,
      required this.sku,
      required this.weight,
      required this.dimensions,
      required this.warrantyInformation,
      required this.shippingInformation,
      required this.availabilityStatus,
      required this.reviews,
      required this.returnPolicy,
      required this.minimumOrderQuantity,
      required this.meta,
      required this.images,
      required this.thumbnail});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions,
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((x) => x.toMap()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta.toMap(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      price: map['price'] as num,
      discountPercentage: map['discountPercentage'] as num,
      rating: map['rating'] as num,
      stock: map['stock'] as num,
      tags: List<String>.from((map['tags'] as List<dynamic>)),
      brand: map['brand'] != null ? map['brand'] as String : null,
      sku: map['sku'] as String,
      weight: map['weight'] as num,
      dimensions:
          Map<String, num>.from((map['dimensions'] as Map<String, dynamic>)),
      warrantyInformation: map['warrantyInformation'] as String,
      shippingInformation: map['shippingInformation'] as String,
      availabilityStatus: map['availabilityStatus'] as String,
      reviews: List<Review>.from(
        (map['reviews'] as List<dynamic>).map<Review>(
          (x) => Review.fromMap(x as Map<String, dynamic>),
        ),
      ),
      returnPolicy: map['returnPolicy'] as String,
      minimumOrderQuantity: map['minimumOrderQuantity'] as num,
      meta: Meta.fromMap(map['meta'] as Map<String, dynamic>),
      images: List<String>.from((map['images'] as List<dynamic>)),
      thumbnail: map['thumbnail'] as String,
    );
  }

  ProductEntity toEntity() => ProductEntity(
        id: id,
        title: title,
        description: description,
        category: category,
        price: price,
        discountPercentage: discountPercentage,
        rating: rating,
        stock: stock,
        tags: tags,
        brand: brand,
        sku: sku,
        weight: weight,
        dimensions: dimensions,
        warrantyInformation: warrantyInformation,
        shippingInformation: shippingInformation,
        availabilityStatus: availabilityStatus,
        reviews: reviews.map((review) => review.toEntity()).toList(),
        returnPolicy: returnPolicy,
        minimumOrderQuantity: minimumOrderQuantity,
        meta: meta.toEntity(),
        images: images,
        thumbnail: thumbnail,
      );
}
