import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProducts on Model {
  List<Product> products = [];
  User authenticatedUser;
  int selProductIndex;

  void addProduct(
      String title, String description, double price, String imageURL) {
    final Product newProduct = Product(
        title: title,
        description: description,
        price: price,
        imageURL: imageURL,
        userEmail: authenticatedUser.email,
        userId: authenticatedUser.id);

    products.add(newProduct);
    selProductIndex = null;
    notifyListeners();
  }
}
