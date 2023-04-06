import 'package:flutter/material.dart';

import '../../models/appointment.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class SuppliersScreen extends StatelessWidget {

  List<ChooseCategory> categories = [
    ChooseCategory(category: 'Cleaning'),
    ChooseCategory(category: 'Kitchen'),
    ChooseCategory(category: 'Plumbing'),
    ChooseCategory(category: 'Paint'),
    ChooseCategory(category: 'Carpentry'),
    ChooseCategory(category: 'Electricity'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: SizedBox(
            height: 30,
            width: double.infinity,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {},
                  child: Container(
                    width: 90,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        categories[index].category,
                        style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: categories.length),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: defaultSuppliersItem(
                context:context ,
                mark: '5.4.3',
                agentName: 'agentName',
                jop: 'jop',
                address: 'address',
                distance: 'distance',
                count: 10
            )
        ),
      ],
    );
  }
}
