import 'package:flutter/material.dart';
import 'package:toptal_test/utils/utils.dart';

class UserDeletedPage extends StatefulWidget {
  @override
  _UserDeletedPageState createState() => _UserDeletedPageState();
}

class _UserDeletedPageState extends State<UserDeletedPage> {
  bool isError = false;

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 5),
    ).then((value) => runCatching(() {
          setState(() {
            isError = true;
          });
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !isError ? CircularProgressIndicator() : Text('User not found'),
      ),
    );
  }
}
