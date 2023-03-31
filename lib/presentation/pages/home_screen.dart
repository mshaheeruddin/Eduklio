import 'package:flutter/material.dart';
import '../components/../../domain/usecases/signout_usecase.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  Logout logout = Logout();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(onPressed: () {
            logout.logOut(context);
          }, icon: Icon(Icons.exit_to_app)),
        ],

      ),
    );
  }
}
