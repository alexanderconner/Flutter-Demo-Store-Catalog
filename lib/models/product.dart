import 'package:flutter/material.dart';

//We use final for the properties so that we cannot edit properties of a product other than using the ScopedProductModel Helper methods. 
class Product {
  final String title;
  final String description;
  final double price;
  final String imageURL;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  Product(
      {@required this.title,
      @required this.description,
      @required this.price,
      @required this.imageURL,
      @required this.userEmail,
      @required this.userId,
      this.isFavorite = false});
}
