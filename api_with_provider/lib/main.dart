import 'package:flutter/material.dart';

import 'const.dart';
import 'home/home_screen.dart';
import 'product_detail/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: PRODUCT_DETAIL_SCREEN,
      routes: {
        HOME_SCREEN: (context) => const HomeScreen(),
        PRODUCT_DETAIL_SCREEN: (context) => const ProductDetailScreen(),
      },
    );
  }
}
