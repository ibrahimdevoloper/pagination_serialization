import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/src/core/paging_controller.dart';
import 'package:pagination_serialization/GetX/Services/UserService.dart';
import 'package:pagination_serialization/Model/User/User.dart';

class UserGetController extends GetxController {
  var isLoading = false;
  // List<User> users = [];
  var isError = false;
  PagingController<int, User> pagingController;

  UserGetController(this.pagingController) {
    pagingController.addPageRequestListener((pageKey) {
      print(pageKey);
      getUsersPage(pageKey);
    });
  }
  //
  // @override
  // void onInit() {
  //   getUsers();
  // }

  @override
  void dispose() {
    pagingController.dispose();
  }

  // getUsers() async {
  //   users = [];
  //   isLoading = true;
  //   // update();
  //   try {
  //     var response = await UserService().getUsers();
  //     print(response);
  //     response.body.forEach((element) {
  //       print(User.fromJson(element));
  //       users.add(User.fromJson(element));
  //     });
  //     pagingController.appendPage(users, 0);
  //     isLoading = false;
  //     // update();
  //   } catch (e) {
  //     // TODO: catch Error
  //     print(e);
  //     isLoading = false;
  //     isError = true;
  //     pagingController.error = e;
  //     // update();
  //   }
  // }

  getUsersPage(int pageNumber) async {
    // print(pageNumber);
    isLoading = true;
    // update();
    try {
      var response = await UserService().getUsers();
      // print(response);
      List<User> users = [];
      if (pageNumber == 0) {
        response.body.forEach((element) {
          // print(User.fromJson(element));
          users.add(User.fromJson(element));
        });
        pagingController.appendPage(users, pageNumber + users.length);
      } else {
        users = [];
        pagingController.appendLastPage(users);
      }

      isLoading = false;
      // update();
    } catch (e) {
      // TODO: catch Error
      print(e);
      isLoading = false;
      isError = true;
      pagingController.error = e;
      // update();
    }
  }
}
