import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  String firebaseURL =
      'https://flutter-products-demo-1649e.firebaseio.com/products.json';

  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;
  bool _isLoading = false;

  Future<Null> addProduct(
      String title, String description, double price, String imageURL) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg',
      'price': price,
      'userEmail' : _authenticatedUser.email,
      'userId' : _authenticatedUser.id,
    };
    return http
        .post(firebaseURL, body: json.encode(productData))
        .then((http.Response response) {
      _isLoading = false;
      final Map<String, dynamic> responseData = json.decode(response.body);

      print('Response Data: ' + responseData.toString());

      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          price: price,
          imageURL: imageURL,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      notifyListeners();
    });
  }
}

mixin ScopedProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

//This get returns not the original list but a pointer to a new list copy,
//this ensures we only edit the list usin the helper methods (add, update, delete etc)
  List<Product> get allProducts {
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

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
    _selProductIndex = null;
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
    _products[selectedProductIndex] = updatedProduct;
    _selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }

  void fetchProducts() {
    _isLoading = true;
    notifyListeners();
    http.get(firebaseURL).then((http.Response response) {
      _isLoading = false;
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      print(productListData.toString());
      if (productListData == null) {
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            imageURL: productData['image'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userId']);

        fetchedProductList.add(product);
      });

      _products = fetchedProductList;
      notifyListeners();
    });
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  void toggleProductisFavorite() {
    final bool isCurrentlyFavorite = _products[selectedProductIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    // final Product updatedProduct = Product(
    //     title: selectedProduct.title,
    //     description: selectedProduct.description,
    //     price: selectedProduct.price,
    //     userEmail: selectedProduct.userEmail,
    //     userId: selectedProduct.userId,
    //     imageURL: selectedProduct.imageURL,
    //     isFavorite: newFavoriteStatus);
    updateProduct(selectedProduct.title, selectedProduct.description,
        selectedProduct.price, selectedProduct.userEmail);
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin ScopedUsersModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: '1234asdf', email: email, password: password);
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
