import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricoz/view/productcard.dart';

class Productpage extends StatefulWidget {
  const Productpage({super.key});

  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.13,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products',
              style: GoogleFonts.roboto(
                fontSize: 29,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Super Sumer Sale',
              style: GoogleFonts.roboto(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: ProductCard(),
    );
  }
}
