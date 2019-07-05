import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

import '../widgets/products/product_title.dart';
import '../widgets/products/address_tag.dart';
import 'package:flutter_course_01/scoped_models/main_model.dart';

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);

  Row _buildAddressPriceRow(BuildContext context, double price) {
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
              '\$${price.toString()}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      print('Back Button Pressed');
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.allProducts[index].title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(model.allProducts[index].imageURL == null
                  ? 'assets/food.jpg'
                  : model.allProducts[index].imageURL),
              Container(
                child: ProductTitle(model.allProducts[index].title),
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: _buildAddressPriceRow(context, model.allProducts[index].price),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(model.allProducts[index].description),
              ),
            ],
          ),
        );
      },
    ));
  }
}
