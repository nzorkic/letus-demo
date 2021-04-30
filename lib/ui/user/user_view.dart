import 'package:flutter/material.dart';
// import 'package:letus/services/user_service.dart';
// import 'package:letus/app/app.locator.dart';

class UserView extends StatelessWidget {
  //UserService get _userService => locator<UserService>();

  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final String _email = _userService.currentUser.email ?? '';

    return const Scaffold(
      body: Center(
        child: Text('This is user page'),
      ),
    );
  }
}
