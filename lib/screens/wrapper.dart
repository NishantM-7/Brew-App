import 'package:flutter/material.dart';
import 'package:testapp/models/customuser.dart';
import 'package:testapp/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:testapp/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    print(user);
    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
