import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import 'pages/productsHome.dart';
import './pages/productAdmin.dart';
import './pages/product.dart';

main() {
  // debugPaintSizeEnabled =true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent),
      //You can define home in the app, OR a '/' route, never both
      //home: AuthPage(),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/home': (BuildContext context) => ProductsHomePage(_products),
        '/admin': (BuildContext context) => ProductAdminPage(_products, _addProduct, _deleteProduct, _updateProduct),
        '/auth': (BuildContext context) => AuthPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) =>
                ProductPage(_products[index]),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) => ProductsHomePage(_products));
      },
    );
  }

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _updateProduct(int index, Map<String, dynamic> product) {
    setState(() {
      _products[index] = product;
    });
  }
}
