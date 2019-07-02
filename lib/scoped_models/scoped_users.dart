import 'package:flutter_course_01/models/user.dart';
import 'package:scoped_model/scoped_model.dart';


mixin ScopedUsersModel on Model {
  User _authenticatedUser;

  void login(String email, String password) {
    _authenticatedUser = User(id: '1234asdf', email: email, password: password);
  }
}