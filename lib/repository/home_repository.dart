import 'package:flutter/foundation.dart';
import 'package:flutter_ios_android_mvvm/data/models/product_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ProductModel> getProductList() async {
    try {
      dynamic response = await _apiServices.getGetResponse(AppUrl.moviesUrl);
      if (kDebugMode) {
        print("response $response");
      }
      return response = ProductModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
      throw e;
    }
  }
}
