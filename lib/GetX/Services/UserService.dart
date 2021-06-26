import 'package:get/get_connect/connect.dart';

class UserService extends GetConnect {
  Future<Response> getUsers() =>
      get('https://jsonplaceholder.typicode.com/users');
}
