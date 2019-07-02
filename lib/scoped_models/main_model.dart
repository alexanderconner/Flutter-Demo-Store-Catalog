import 'package:scoped_model/scoped_model.dart';

import 'connected_products_model.dart';
import './scoped_products.dart';
import './scoped_users.dart';

class MainModel extends Model with ConnectedProducts, ScopedProductsModel, ScopedUsersModel {}