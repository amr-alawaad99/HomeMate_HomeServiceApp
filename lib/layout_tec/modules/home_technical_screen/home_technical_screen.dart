import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/layout_tec/modules/home_technical_screen/in_progress_screen.dart';

import '../../../shared/components/constants.dart';
import 'accepted_screen.dart';

class HomeTechnicalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          animationDuration: Duration(seconds: 1),
          initialIndex: LayoutCubit.get(context).currentTabIndex,
          length: 2,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  shadowColor: Colors.black,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TabBar(
                      onTap: (currentIndex) {
                        LayoutCubit.get(context).changeTabView(currentIndex);
                      },
                      labelPadding: EdgeInsets.symmetric(horizontal: 30),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor,
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            'Progress',
                            style: TextStyle(
                              color:
                                  LayoutCubit.get(context).currentTabIndex == 0
                                      ? Colors.white
                                      : Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Accepted',
                            style: TextStyle(
                              color:
                                  LayoutCubit.get(context).currentTabIndex == 0
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: const [
                  //For Progress Orders
                    InProgressScreen(),
                  //For Accepted Orders
                    AcceptedScreen(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
