import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: Column(
            children: <Widget>[
              AppBar(title: Text('Choose'), automaticallyImplyLeading: false),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Manage Products"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/admin');
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