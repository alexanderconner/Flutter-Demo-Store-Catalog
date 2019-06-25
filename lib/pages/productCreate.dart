import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue = '';
  String _description = '';
  double _price = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Product Title",
      ),
      autofocus: true,
      maxLength: 30,
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty) {
          return "Title is required";
        }
      },
      onSaved: (String value) {
        setState(() {
          _titleValue = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Enter Description"),
      maxLines: 4,
      onSaved: (String value) {
        setState(() {
          _description = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Price"),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        setState(() {
          _price = double.parse(value);
        });
      },
    );
  }

  void _submitForm() {
    //if any form field fails validation return, if valid
    //save state and navigate to show the product
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      _formKey.currentState.save();
      final Map<String, dynamic> product = {
        'title': _titleValue,
        'image': 'assets/food.jpg',
        'description': _description,
        'price': _price
      };
      widget.addProduct(product);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final targetPadding = (deviceWidth - targetWidth) / 2;

    return Container(
      width: targetWidth,
      margin: EdgeInsets.all(10.0),
      child: Form(
        //A global key id to allow us to access a reference to the internal state of this form
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding),
          children: <Widget>[
            _buildTitleTextField(),
            _buildDescriptionTextField(),
            _buildPriceTextField(),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text("Save Product"),
              onPressed: () => _submitForm(),
            )
            // GestureDetector(
            //   onTap: () {
            //     _submitForm();
            //   },
            //   child: Container(
            //     color: Colors.green,
            //     padding: EdgeInsets.all(5.0),
            //     child: Text('Button'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
