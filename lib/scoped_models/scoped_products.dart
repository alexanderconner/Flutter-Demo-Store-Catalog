import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

mixin ScopedProductsModel on Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  bool _showFavorites = false;

//This get returns not the original list but a pointer to a new list copy,
//this ensures we only edit the list usin the helper methods (add, update, delete etc)
  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  void toggleProductisFavorite() {
    final bool isCurrentlyFavorite =
        _products[_selectedProductIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        imageURL: selectedProduct.imageURL,
        isFavorite: newFavoriteStatus);
    updateProduct(updatedProduct);
    notifyListeners();
    _selectedProductIndex = null;
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
