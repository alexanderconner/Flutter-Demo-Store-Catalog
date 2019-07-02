import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../widgets/drawer/home_drawer.dart';
import '../scoped_models/main_model.dart';
import '../models/product.dart';

//AKA Products page
class ProductsHomePage extends StatelessWidget {
  final List<Product> products;

  ProductsHomePage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          title: Text('EasyList'),
          actions: <Widget>[
            ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child,
                  MainModel model) {
                return IconButton(
                  icon: Icon(model.displayFavoritesOnly
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    model.toggleDisplayMode();
                  },
                );
              },
            )
          ],
        ),
        body: Products());
  }
}
