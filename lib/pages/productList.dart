import 'package:flutter/material.dart';

import 'package:flutter_course_01/pages/product_edit.dart';
import '../models/product.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage({this.updateProduct, this.products, this.deleteProduct});

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ProductEditPage(
              updateProduct: updateProduct,
              product: products[index],
              productIndex: index,
            );
          }),
        );
      },
    );
  }

  Widget _buildListTile(BuildContext context, index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(products[index].imageURL),
      ),
      title: Text(products[index].title),
      subtitle: Text('\$${products[index].price}'),
      trailing: _buildEditButton(context, index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index].title),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              deleteProduct(index);
            } else if (direction == DismissDirection.startToEnd) {
              print("start  to end");
            } else {
              print("other swiping");
            }
          },
          direction: DismissDirection.endToStart,
          background: Container(color: Colors.red),
          child: Column(
            children: <Widget>[
              _buildListTile(context, index),
              Divider(),
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
