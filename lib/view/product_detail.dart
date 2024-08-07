import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:ricoz/models/card_model.dart';

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
          toolbarHeight: MediaQuery.of(context).size.height * 0.13,
          centerTitle: true,
          title: Text(productDetail.title,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlutterCarousel(
                options: CarouselOptions(
                  height: 400.0,
                ),
                items: productDetail.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image(
                          image: NetworkImage(
                            i,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
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
        ));
  }
}
