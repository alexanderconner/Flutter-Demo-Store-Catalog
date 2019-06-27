import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/dialogs/delete_confirm.dart';
import '../widgets/products/product_title.dart';
import '../widgets/products/address_tag.dart';
import 'package:flutter_course_01/models/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  Row _buildAddressPriceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 70,
          child: AddressTag('Union Square, San Francisco'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Flexible(
          flex: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              '\$${product.price.toString()}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print('Back Button Pressed');
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(product.imageURL == null
                  ? 'assets/food.jpg'
                  : product.imageURL),
              Container(
                child: ProductTitle(product.title),
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: _buildAddressPriceRow(context),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(product.description)),
            ],
          ),
        ));
  }
}
