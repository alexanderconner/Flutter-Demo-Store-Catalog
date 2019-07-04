import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/auth.dart';
import 'pages/productsHome.dart';
import './pages/productAdmin.dart';
import './pages/product.dart';
import './scoped_models/main_model.dart';


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
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      //Model is the Scoped Model of the Products list which 
      //we instantiate for the entire widget tree (Material App)
      model: model,
      child: MaterialApp(
        //debugShowMaterialGrid: true,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            accentColor: Colors.blueAccent),
        //You can define home in the app, OR a '/' route, never both
        //home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/home': (BuildContext context) => ProductsHomePage(model),
          '/admin': (BuildContext context) => ProductAdminPage(),
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
              builder: (BuildContext context) => ProductPage(index),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsHomePage(model));
        },
      ),
    );
  }
}
