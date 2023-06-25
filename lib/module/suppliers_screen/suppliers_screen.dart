import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';

import '../../layout/cubit/states.dart';
import '../../model/appointment.dart';
import '../../model/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class SuppliersScreen extends StatelessWidget {
  List<ChooseCategory> categories = [
    ChooseCategory(category: 'All'),
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
    return BlocConsumer<LayoutCubit, LayoutStates>(
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
                              border: cubit.suppliersSelectedIndex == index
                                  ? Border.all(
                                      width: 1.5,
                                      color: secondaryColor,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                categories[index].category,
                                style: TextStyle(
                                  color: cubit.suppliersSelectedIndex == index
                                      ? secondaryColor
                                      : Colors.grey,
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
            StreamBuilder<List<UserModel>>(
              stream: cubit.techs(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error No Data found! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final techs = snapshot.data!.reversed;
                  return ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: techs
                        .map(
                          (e) => defaultSuppliersItem(
                            model: e,
                            context: context,
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
