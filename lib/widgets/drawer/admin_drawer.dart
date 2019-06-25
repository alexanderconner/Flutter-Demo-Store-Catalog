import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(title: Text('Choose'), automaticallyImplyLeading: false),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("All Products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/auth');
            },
          )
        ],
      ),
    );
  }
}
