import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ios_android_mvvm/data/response/api_response.dart';
import 'package:flutter_ios_android_mvvm/repository/home_repository.dart';

import '../data/models/product_model.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepo = HomeRepository();
  ApiResponse<ProductModel> productList = ApiResponse.loading();

  setProductList(ApiResponse<ProductModel> response) {
    productList = response;
    notifyListeners();
  }

  Future<void> fetchProductList() async {
    setProductList(ApiResponse.loading());
    _homeRepo.getProductList().then((value) {
      setProductList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setProductList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
