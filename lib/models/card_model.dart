import 'dart:developer';

class CardModel {
  String title;
  String image;
  String description;
  List<String> images;
  String? brand;
  double rating;
  double price;
  String discountPercent;
  CardModel({
    required this.description,
    required this.title,
    required this.images,
    required this.image,
    this.brand,
    required this.rating,
    required this.price,
    required this.discountPercent,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      description: json['description'],
      images: List<String>.from(json['images']),
      title: json['title'],
      image: json['thumbnail'],
      brand: json['brand'] ?? 'Unknown',
      rating: json['rating'],
      price: json['price'],
      discountPercent: json['discountPercentage'].toString(),
    );
  }
}
