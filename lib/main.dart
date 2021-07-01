import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pagination_serialization/GetX/Controller/UserGetController.dart';
import 'package:pagination_serialization/Model/User/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PagingController<int, User> _pagingController = PagingController<int, User>(
      firstPageKey: 0,
    );
    final UserGetController userGetController =
        Get.put(UserGetController(_pagingController));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userGetController.addUsers();
        },
      ),
      appBar: AppBar(),
      body: GetBuilder<UserGetController>(builder: (controller) {
        // if (controller.isLoading)
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // else if (controller.isError)
        //   return Center(
        //     child: Text("error"),
        //   );
        // else
        return RefreshIndicator(
          onRefresh: () => controller.getUsersPage(0),
          child: PagedListView<int, User>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<User>(
              itemBuilder: (context, user, index) => ListTile(
                title: Text(user.name),
              ),
              firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(),
              noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
            ),
          ),
        );
        // }
      }),
    );
  }
}

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Image.asset("assets/error.png"),
      ),
    );
  }
}

class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Image.asset("assets/box.png"),
      ),
    );
  }
}
