import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pagination_serialization/GetX/Controller/UserGetController.dart';

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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserGetController userGetController = Get.put(UserGetController());
    return Scaffold(
      body: GetBuilder<UserGetController>(builder: (controller) {
        if (controller.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (controller.isError)
          return Center(
            child: Text("error"),
          );
        else {
          return ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.users[index].name),
                  subtitle: Text(controller.users[index].address.city),
                );
              });
        }
      }),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
