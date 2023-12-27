import 'package:flutter/cupertino.dart';
import 'package:flutter_ios_android_mvvm/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel userModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', userModel.token.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    return UserModel(token: token.toString());
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}
