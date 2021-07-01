import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/src/core/paging_controller.dart';
import 'package:pagination_serialization/Model/Address/Address.dart';
import 'package:pagination_serialization/Model/Company/Company.dart';
import 'package:pagination_serialization/Model/Geo/Geo.dart';
import 'package:pagination_serialization/Model/User/User.dart';

class UserGetController extends GetxController {
  var isLoading = false;

  // List<User> users = [];
  var isError = false;
  PagingController<int, User> pagingController;

  var lastDoc;

  FakeFirebaseFirestore firestore = FakeFirebaseFirestore();

  UserGetController(this.pagingController) {
    firestore = FakeFirebaseFirestore();
    pagingController.addPageRequestListener((pageKey) {
      print(pageKey);
      getUsersPage(pageKey);
    });
  }

  // @override
  // Future<void> onInit() async {
  //   // getUsers();
  //
  //   pagingController.addPageRequestListener((pageKey) {
  //     print(pageKey);
  //     getUsersPage(pageKey);
  //   });
  // }

  addUsers() async {
    isLoading = true;
    update();
    // final firestore = FakeFirebaseFirestore();
    for (int i = 0; i <= 100; i++) {
      // print(User(
      //         i++,
      //         "Ibrahim",
      //         "Nexttron",
      //         "Email@email.com",
      //         Address("street", "city", "suite", "zipcode", Geo("lat", "lng")),
      //         "009635525515",
      //         "www.yourhelp.plz",
      //         Company("company", "Slogan", "bs"))
      //     .toJson());
      await firestore.collection("users").add(User(
              i++,
              "Ibrahim${i++}",
              "Nexttron",
              "Email@email.com",
              Address("street", "city", "suite", "zipcode", Geo("lat", "lng")),
              "009635525515",
              "www.yourhelp.plz",
              Company("company", "Slogan", "bs"))
          .toJson());
    }
    isLoading = false;
    update();
  }

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
    // // print(pageNumber);
    // isLoading = true;
    // // update();
    // try {
    //   var response = await UserService().getUsers();
    //   // print(response);
    //   List<User> users = [];
    //   if (pageNumber == 0) {
    //     response.body.forEach((element) {
    //       // print(User.fromJson(element));
    //       users.add(User.fromJson(element));
    //     });
    //     pagingController.appendPage(users, pageNumber + users.length);
    //   } else {
    //     users = [];
    //     pagingController.appendLastPage(users);
    //   }
    //
    //   isLoading = false;
    //   // update();
    // } catch (e) {
    //   // TODO: catch Error
    //   print(e);
    //   isLoading = false;
    //   isError = true;
    //   pagingController.error = e;
    //   // update();
    // }

    List<User> users = [];
    var elementNumberPerPage = 20;
    if (pageNumber == 0) {
      var usersQuery =
          await firestore.collection("users").limit(elementNumberPerPage).get();
      usersQuery.docs.forEach((element) {
        print("element:$element");
        users.add(User.fromJson(element.data()));
        lastDoc = element;
      });
      // lastDoc = usersQuery.docs.last;
      // return users;
      if (elementNumberPerPage <= users.length)
        pagingController.appendPage(users, pageNumber + users.length);
      else
        pagingController.appendLastPage(users);
    } else {
      var usersQuery = await firestore
          .collection("users")
          .startAfterDocument(lastDoc)
          .limit(elementNumberPerPage)
          .get();
      usersQuery.docs.forEach((element) {
        print("element:$element");
        users.add(User.fromJson(element.data()));
        lastDoc = element;
      });
      // lastDoc = usersQuery.docs.last;
      // return users;
      if (elementNumberPerPage <= users.length)
        pagingController.appendPage(users, pageNumber + users.length);
      else
        pagingController.appendLastPage(users);
    }
  }
}
