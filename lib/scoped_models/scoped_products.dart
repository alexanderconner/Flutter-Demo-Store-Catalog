import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import './connected_products_model.dart';

mixin ScopedProductsModel on ConnectedProducts {
  bool _showFavorites = false;

//This get returns not the original list but a pointer to a new list copy,
//this ensures we only edit the list usin the helper methods (add, update, delete etc)
  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void deleteProduct() {
    products.removeAt(selectedProductIndex);
    selProductIndex = null;
    notifyListeners();
  }

  void updateProduct(
      String title, String description, double price, String imageURL) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        price: price,
        imageURL: imageURL,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    products[selectedProductIndex] = updatedProduct;
    selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    selProductIndex = index;
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return products[selectedProductIndex];
  }

  void toggleProductisFavorite() {
    final bool isCurrentlyFavorite = products[selectedProductIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    // final Product updatedProduct = Product(
    //     title: selectedProduct.title,
    //     description: selectedProduct.description,
    //     price: selectedProduct.price,
    //     userEmail: selectedProduct.userEmail,
    //     userId: selectedProduct.userId,
    //     imageURL: selectedProduct.imageURL,
    //     isFavorite: newFavoriteStatus);
    updateProduct(selectedProduct.title,
        selectedProduct.description,
        selectedProduct.price,
        selectedProduct.userEmail);
    notifyListeners();
    selProductIndex = null;
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
