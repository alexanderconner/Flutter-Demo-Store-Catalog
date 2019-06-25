import 'package:flutter/material.dart';


import '../widgets/products/products.dart';
import '../widgets/drawer/home_drawer.dart';

class ProductsHomePage extends StatelessWidget {

  final List<Map<String, dynamic>> products;

  ProductsHomePage(this.products);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          title: Text('EasyList'),
          actions: <Widget>[
            IconButton(icon: Icon(
              Icons.favorite), 
              onPressed: () {},)
          ],
        ),
        body: Products(products));
  }
}
