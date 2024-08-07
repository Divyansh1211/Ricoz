import 'dart:developer';

class CardModel {
  String title;
  String image;
  String? brand;
  double rating;
  double price;
  String discountPercent;
  CardModel({
    required this.title,
   required this.image,
    this.brand,
   required this.rating,
   required this.price,
   required this.discountPercent,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    // log(json.toString());
    return CardModel(
      title: json['title'],
      image: json['thumbnail'],
      brand: json['brand'] ?? 'Unknown',
      rating: json['rating'],
      price: json['price'],
      discountPercent: json['discountPercentage'].toString(),
    );
  }
}