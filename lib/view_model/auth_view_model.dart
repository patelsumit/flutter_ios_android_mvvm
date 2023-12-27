import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ios_android_mvvm/data/models/user_model.dart';
import 'package:flutter_ios_android_mvvm/repository/auth_repository.dart';
import 'package:flutter_ios_android_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_ios_android_mvvm/utils/utils.dart';
import 'package:flutter_ios_android_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _repo = AuthRepository();
  bool _loading = false;

  bool get loading => _loading;

  bool _signUpLoading = false;

  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _repo.loginApi(data).then((value) {
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(UserModel(token: value['token'].toString()));
      Utils.flushBarMessage('Login Success..', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _repo.registerApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarMessage('Sign up Success..', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
