import 'package:flutter_ios_android_mvvm/data/network/BaseApiServices.dart';
import 'package:flutter_ios_android_mvvm/data/network/NetworkApiServices.dart';
import 'package:flutter_ios_android_mvvm/res/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostResponse(AppUrl.loginEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostResponse(AppUrl.registerEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
