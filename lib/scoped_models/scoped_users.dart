import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';
import './connected_products_model.dart';

mixin ScopedUsersModel on ConnectedProducts {
  void login(String email, String password) {
    authenticatedUser = User(id: '1234asdf', email: email, password: password);
  }
}