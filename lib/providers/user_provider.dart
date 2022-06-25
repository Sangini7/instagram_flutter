import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners(); //notify all the user providers that the data of our user has changed so update the value
  }
}
