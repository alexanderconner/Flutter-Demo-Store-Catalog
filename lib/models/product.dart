import 'package:flutter/material.dart';

//We use final for the properties so that we cannot edit properties of a product other than using the ScopedProductModel Helper methods. 
class Product {
  final String title;
  final String description;
  final double price;
  final String imageURL;
  final bool isFavorite;

  Product(
      {@required this.title,
      @required this.description,
      @required this.price,
      @required this.imageURL,
      this.isFavorite = false});
}
