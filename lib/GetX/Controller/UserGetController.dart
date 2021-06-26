import 'package:get/get.dart';
import 'package:pagination_serialization/GetX/Services/UserService.dart';
import 'package:pagination_serialization/Model/User/User.dart';

class UserGetController extends GetxController {
  var isLoading = false;
  List<User> users = [];
  var isError = false;

  @override
  void onInit() {
    getUsers();
  }

  getUsers() async {
    isLoading = true;
    update();
    try {
      var response = await UserService().getUsers();
      print(response);
      response.body.forEach((element) {
        print(User.fromJson(element));
        users.add(User.fromJson(element));
      });
      isLoading = false;
      update();
    } catch (e) {
      // TODO: catch Error
      print(e);
      isLoading = false;
      isError = true;
      update();
    }
  }
}
