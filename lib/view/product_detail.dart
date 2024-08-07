import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:ricoz/models/card_model.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProductDetail extends StatelessWidget {
  CardModel productDetail;

  ProductDetail({super.key, required this.productDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: 24,
            ),
          ),
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        centerTitle: true,
        title: Text(productDetail.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.78,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  FlutterCarousel(
                    options: CarouselOptions(
                      showIndicator: false,
                      height: 400.0,
                    ),
                    items: productDetail.images.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.network(
                                i,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.grey[200],
                                      width: MediaQuery.of(context).size.width,
                                      height: 400,
                                    ),
                                  );
                                },
                              ));
                        },
                      );
                    }).toList(),
                  ),
                  const Positioned(
                    right: 20,
                    top: 5,
                    child: CircleAvatar(
                      
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            productDetail.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${(productDetail.price - (productDetail.price * double.parse(productDetail.discountPercent) / 100)).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      productDetail.brand!,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        StarRating(
                          mainAxisAlignment: MainAxisAlignment.start,
                          size: 20,
                          rating: productDetail.rating,
                          color: Colors.orange,
                          borderColor: Colors.grey,
                          starCount: 5,
                        ),
                        Text(
                          '(${productDetail.rating.toString()})',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      productDetail.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: MediaQuery.of(context).size.height * 0.09,
        width: double.infinity,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 219, 48, 34),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                'ADD TO CART',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
