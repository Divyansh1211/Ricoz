import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricoz/models/card_model.dart';
import 'package:http/http.dart' as http;
import 'package:ricoz/view/bottomnav.dart';
import 'package:ricoz/view/product_detail.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<CardModel> productcard = [];
  String? discountedPrice;

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> products = data['products'];
      setState(() {
        productcard =
            products.map((product) => CardModel.fromJson(product)).toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: productcard.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(
                      productDetail: productcard[index],
                    ),
                  ),
                );
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.grey[200],
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.32,
                    child: Stack(
                      children: [
                        Center(
                          child: Image(
                            image: NetworkImage(
                              productcard[index].image,
                            ),
                          ),
                        ),
                        Container(
                          padding: (const EdgeInsets.all(1)),
                          width: 45,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red),
                          child: Center(
                            child: Text(
                              '-${double.parse(productcard[index].discountPercent).toInt().toString()}%',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            StarRating(
                              mainAxisAlignment: MainAxisAlignment.end,
                              size: 15,
                              rating: productcard[index].rating,
                              filledIcon: Icons.star,
                              halfFilledIcon: Icons.star_outline_outlined,
                              emptyIcon: Icons.star_outline,
                              color: Colors.red,
                              borderColor: Colors.grey,
                            ),
                            Text(
                              productcard[index].rating.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(productcard[index].brand!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                        Text(
                          textAlign: TextAlign.right,
                          productcard[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${productcard[index].price}\$',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              ' ${discountedPrice = (productcard[index].price - (productcard[index].price * double.parse(productcard[index].discountPercent) / 100)).toStringAsFixed(2)}\$',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const Bottomnav(),
    );
  }
}
