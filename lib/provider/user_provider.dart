import 'package:flutter/material.dart';
import 'package:instagram_clone/Firebase_Auth/authentication_methods.dart';
import 'package:instagram_clone/model/user_model.dart' as user_model;

class UserProivder with ChangeNotifier {
  user_model.userModel? _user;

  final AuthMethods _authMethods = AuthMethods();

  user_model.userModel get getUser => _user!;

  Future<void> refreshUser() async {
    user_model.userModel _userData = await _authMethods.getUserDetails();
    _user = _userData;
    notifyListeners();
  }
}
