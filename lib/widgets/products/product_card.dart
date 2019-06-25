import 'package:flutter/material.dart';

import './address_tag.dart';
import './product_title.dart';
import './product_price.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int position;

  ProductCard(this.product, this.position);

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pushNamed<bool>(
                context, '/product/' + position.toString());
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: () {
            print("added to favorites");
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Column(
        children: <Widget>[
          Image.asset(product['image']),
          //SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: ProductTitle(product['title'])),
                SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: ProductPrice(product['price'].toString()),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          AddressTag('San Francisco'),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}
