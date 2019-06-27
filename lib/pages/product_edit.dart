import 'package:flutter/material.dart';

import '../widgets/helpers/ensure-visible.dart';
import '../models/product.dart';

/**
 * A form for both adding and updating existing products. 
 * If we are adding a new product, only supply the addProduct argument. 
 * If updating, pass the existing product, its index, and the update Method 
 * to update that product list. 
 */
class ProductEditPage extends StatefulWidget {
  final Product product;
  final Function updateProduct;
  final Function addProduct;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Widget _buildTitleTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(
          labelText: "Product Title",
        ),
        autofocus: true,
        initialValue: widget.product == null ? '' : widget.product.title,
        maxLength: 30,
        validator: (String value) {
          if (value.isEmpty || value.length < 5) {
            return "Title is required and should be at least 5 characters long";
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        decoration: InputDecoration(labelText: "Enter Description"),
        maxLines: 4,
        initialValue: widget.product == null ? '' : widget.product.description,
        validator: (String value) {
          if (value.isEmpty || value.length < 10) {
            return "Descripton is required and should be at least 10 characters long";
          }
        },
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(labelText: "Price"),
        initialValue:
            widget.product == null ? '' : widget.product.price.toString(),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return "Price is required and should be a number";
          }
        },
        onSaved: (String value) {
          _formData['price'] = double.parse(value);
        },
      ),
    );
  }

  Widget _buildPageContent(BuildContext context) {
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
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    //if any form field fails validation return, if valid
    //save state and navigate to show the product
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      //TODO add images later
      if (_formData['image'] == null) {
        _formData['image'] = 'assets/food.jpg';
      }
      _formKey.currentState.save();
      Product newProduct = Product(
          title: _formData['title'],
          description: _formData['description'],
          price: _formData['price'],
          imageURL: _formData['image']);
      if (widget.product == null) {
        widget.addProduct(newProduct);
      } else {
        widget.updateProduct(widget.productIndex, newProduct);
      }

      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget pageContent = _buildPageContent(context);

//IF we aleady have a product, we are editing a product and must wrap the page in a Scaffold.
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text("Edit Product"),
            ),
            body: pageContent,
          );
  }
}
