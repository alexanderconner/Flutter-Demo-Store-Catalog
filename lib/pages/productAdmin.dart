import 'package:flutter/material.dart';
import 'package:flutter_course_01/pages/productList.dart';
import 'package:flutter_course_01/pages/product_edit.dart';

import './product_edit.dart';
import './productList.dart';
import '../widgets/drawer/admin_drawer.dart';

class ProductAdminPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function addItem;
  final Function deleteItem;
  final Function updateItem;

  ProductAdminPage(
      this.products, this.addItem, this.deleteItem, this.updateItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: AdminDrawer(),
          appBar: AppBar(
            title: Text('Manage Products'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.add_box),
                  text: 'Create Product',
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: 'My Products',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductEditPage(addProduct: addItem),
              ProductListPage(
                updateProduct: updateItem,
                products: products,
                deleteProduct: deleteItem,
              )
            ],
          ),
        ),
      ),
    );
  }
}
