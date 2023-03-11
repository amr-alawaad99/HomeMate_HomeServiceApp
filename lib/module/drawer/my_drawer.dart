import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_register_methods/shared/components/constants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: scaffoldLightColor,
      child: Column(
        children: [
          Text("Drawer"),
        ],
      ),
    );
  }
}
