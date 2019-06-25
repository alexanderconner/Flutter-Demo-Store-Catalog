import 'package:flutter/material.dart';
import 'package:flutter_course_01/pages/productList.dart';

import './productCreate.dart';
import './productList.dart';
import '../widgets/drawer/admin_drawer.dart';

class ProductAdminPage extends StatelessWidget {

  final Function addItem;
  final Function deleteItem;

  ProductAdminPage(this.addItem, this.deleteItem);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            drawer: AdminDrawer(),
            appBar: AppBar(
              title: Text('Manage Products'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.create),
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
              children: <Widget>[ProductCreatePage(addItem), ProductListPage()],
            )));
  }
}
