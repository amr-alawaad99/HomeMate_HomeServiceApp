import 'package:flutter/material.dart';

import '../../shared/components/components.dart';


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
                mark: '5.4.3',
                agentName: 'agentName',
                jop: 'jopp',
                address: 'address',
                distance: 'distance',
                count: 10)),
      ],
    );
  }
}
