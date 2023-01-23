import 'package:get/get_connect.dart';

class LoginService extends GetConnect {
  Future<Response> postAkses(url, body) {
    return post(url, body);
  }

  Future<Response> postProsesLogin(url, body, token) {
    return post(url, body, headers: {"Authorization": "Bearer $token"});
  }

  Future<Response> getAPI(token, url) {
    return get(url, headers: {"Authorization": "Bearer $token"});
  }
}
