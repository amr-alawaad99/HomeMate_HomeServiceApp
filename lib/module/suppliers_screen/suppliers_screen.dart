import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';

import '../../layout/cubit/states.dart';
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

  SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          cubit.changeSuppliersIndex(index);
                        },
                        child: Container(
                          width: 90,
                          height: 100,
                          decoration: BoxDecoration(
                            border:  cubit.suppliersSelectedIndex == index?Border.all(
                              width: 1.5,
                              color: secondaryColor,
                            ):null,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              categories[index].category,
                              style:  TextStyle(
                                color:  cubit.suppliersSelectedIndex == index?secondaryColor:Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 8,
                      ),
                      itemCount: categories.length),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: defaultSuppliersItem(
                      context: context,
                      mark: '5.4.3',
                      agentName: 'agentName',
                      jop: 'jop',
                      address: 'address',
                      distance: 'distance',
                      count: 10)),
            ],
          );
        },
      ),
    );
  }
}
