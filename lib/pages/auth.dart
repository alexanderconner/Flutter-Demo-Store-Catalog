import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false,
  };

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

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
          labelText: "Email", filled: true, fillColor: Colors.white),
      autocorrect: false,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return "Email is required";
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      autocorrect: false,
      maxLength: 30,
      decoration: InputDecoration(
          labelText: "Password", filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 8) {
          return "Password is required and must be at least 8 characters";
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildAcceptTermsSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      title: Text("Accept Terms"),
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
    );
  }

  void _submitForm() {
    if (!_loginKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    } else {
      _loginKey.currentState.save();
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(image: _buildBackgroundImage()),
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                //Set the width of this container to 80 percent of this screen width
                width: targetWidth,
                child: Form(
                  key: _loginKey,
                  child: Column(
                    children: <Widget>[
                      _buildEmailTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildPasswordTextField(),
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
      ),
    );
  }
}
