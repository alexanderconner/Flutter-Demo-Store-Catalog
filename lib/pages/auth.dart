import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _username;
  String _password;
  bool _acceptTerms = false;

  final _usernameKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      image: AssetImage('assets/background.jpg'),
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Username", filled: true, fillColor: Colors.white),
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      maxLength: 30,
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      autocorrect: false,
      maxLength: 30,
      decoration: InputDecoration(
          labelText: "Password", filled: true, fillColor: Colors.white),
      obscureText: true,
    );
  }

  Widget _buildAcceptTermsSwitch() {
    return SwitchListTile(
      value: _acceptTerms,
      title: Text("Accept Terms"),
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
    );
  }

  void _submitForm() {
    print(_username);
    print(_password);
    if (_acceptTerms) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    //Get Device width
    final double deviceWidth = MediaQuery.of(context).size.width;
    //If device width is greater than 550 we use 500 (landscape), otherwise it is 95% of the width (portait)
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              //Set the width of this container to 80 percent of this screen width
              width: targetWidth,
              child: Form(
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildEmailTextField(),
                    _buildAcceptTermsSwitch(),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: Text('Login'),
                      onPressed: () => _submitForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}