abstract class ApiService {
  Future<dynamic> postRequest(
    String apiName,
    Map<String, dynamic> postData, {
    bool isAuth,
  });

  Future<dynamic> putRequest(
    String apiName,
    Map<String, dynamic> postData, {
    bool isAuth,
  });

  Future<dynamic> getRequest(
    String apiName,
  );
}
