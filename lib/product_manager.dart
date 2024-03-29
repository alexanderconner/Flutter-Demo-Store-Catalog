import 'package:flutter/material.dart';

import './widgets/products/products.dart';
import './models/product.dart';

class ProductManager extends StatelessWidget {
  final List<Product> products;

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: Products())],
    );
  }
}
