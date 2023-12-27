abstract class BaseApiServices {
  Future<dynamic> getGetResponse(String url);

  Future<dynamic> getPostResponse(String url, dynamic data);
}
