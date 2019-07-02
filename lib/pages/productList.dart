import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_course_01/pages/product_edit.dart';
import '../scoped_models/main_model.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage();

  Widget _buildEditButton(
      BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ProductEditPage();
          }),
        );
      },
    );
  }

  Widget _buildListTile(
      BuildContext context, MainModel model, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(model.products[index].imageURL),
      ),
      title: Text(model.products[index].title),
      subtitle: Text('\$${model.products[index].price}'),
      trailing: _buildEditButton(context, index, model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.products[index].title),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectProduct(index);
                  model.deleteProduct();
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
                  _buildListTile(context, model, index),
                  Divider(),
                ],
              ),
            );
          },
          itemCount: model.products.length,
        );
      },
    );
  }
}
