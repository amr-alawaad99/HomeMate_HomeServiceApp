import 'package:flutter/material.dart';
import 'package:login_register_methods/shared/components/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Test Code, Delete this when editing///
        Container(
          width: double.infinity,
          height: 1500,
          color: scaffoldLightColor,
          child: Column(
            children: const [
              Text("Start"),
              Spacer(),
              Text("END"),
            ],
          ),
        ),
      ],
    );
  }
}
