import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/components/constants.dart';

import '../../shared/components/components.dart';

/*Padding(
padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
child: Container(
width: double.infinity,
height: 30,
child: ListView.separated(
itemBuilder: (BuildContext context, int index) =>
defaultCategoryChooser(text: 'Cleaning'),
separatorBuilder: (context, index) => SizedBox(
width: 5,
),
itemCount: 6,
shrinkWrap: true,
scrollDirection: Axis.horizontal,
),
),
),*/
/*Container(
height: MediaQuery.of(context).size.height,
child: ListView.builder(
scrollDirection: Axis.vertical,
shrinkWrap: true,
itemBuilder: (context, index) => SuppliersItem(),
itemCount:10),
),*/
class SuppliersScreen extends StatelessWidget {
  const SuppliersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: defaultCategoryChooser(text: 'Cleaning'),
        ),
        Container(
            height: MediaQuery.of(context).size.height,
            child: defaultSuppliersItem(context:context ,
                mark: 'mark',
                agentName: 'agentName',
                jop: 'jop',
                address: 'address',
                distance: 'distance',
                Count: 10)),
      ],
    );
  }
}
