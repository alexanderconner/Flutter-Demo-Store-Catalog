import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure-visible.dart';
import '../models/product.dart';
import '../scoped_models/main_model.dart';

/**
 * A form for both adding and updating existing products. 
 * If we are adding a new product, only supply the addProduct argument. 
 * If updating, pass the existing product, its index, and the update Method 
 * to update that product list. 
 */
class ProductEditPage extends StatefulWidget {
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

  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(
          labelText: "Product Title",
        ),
        autofocus: true,
        initialValue: product == null ? '' : product.title,
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

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        decoration: InputDecoration(labelText: "Enter Description"),
        maxLines: 4,
        initialValue: product == null ? '' : product.description,
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

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(labelText: "Price"),
        initialValue:
            product == null ? '' : product.price.toString(),
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

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          color: Theme.of(context).accentColor,
          child: Text("Save Product"),
          onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectedProductIndex),
        );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
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
            _buildTitleTextField(product),
            _buildDescriptionTextField(product),
            _buildPriceTextField(product),
            SizedBox(
              height: 10.0,
            ),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  void _submitForm(Function addProduct, Function updateProduct, [int selectedProductIndex]) {
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
      if (selectedProductIndex == null) {
        addProduct(newProduct);
      } else {
        updateProduct(newProduct);
      }

      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    //IF we aleady have a product, we are editing a product and must wrap the page in a Scaffold.
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent = _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text("Edit Product"),
                ),
                body: pageContent,
              );
      },
    );
  }
}
