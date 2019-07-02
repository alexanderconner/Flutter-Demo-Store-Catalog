import 'package:flutter/material.dart';
import 'package:flutter_course_01/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../scoped_models/main_model.dart';


class Products extends StatelessWidget {

  Widget _buildProductList(List<Product> products) {
    Widget productCard =
        Center(child: Text("No Products found, please add some."));

    if (products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
        itemCount: products.length,
      );
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] Build');
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
            return _buildProductList(model.displayedProducts);
    },);
  }
}
