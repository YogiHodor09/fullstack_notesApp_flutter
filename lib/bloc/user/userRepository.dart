import 'package:flutter/src/widgets/framework.dart';
import 'package:notes_app/services/APIProvider.dart';

class UserRepository {
  APIProvider apiProvider = APIProvider();

  Future<void> registerUser(var userName, var password, BuildContext context) {
    return apiProvider.registerUser(userName, password, context);
  }

  Future<void> loginUser(var userName, var password, BuildContext context) {
    return apiProvider.loginUser(userName, password, context);
  }
}
