import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  //final UserService _userService = locator<UserService>();

  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('User'),
      ),
    );
  }
}
