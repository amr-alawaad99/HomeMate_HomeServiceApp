
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';

import '../../layout/cubit/states.dart';
import '../../model/appointment.dart';
import '../../model/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../technical_details_screen/technical_details_screen.dart';

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
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
                width: double.infinity,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            cubit.changeSuppliersIndex(index);
                            print(index);
                          },
                          child: Container(
                            width: 90,
                            height: 100,
                            decoration: BoxDecoration(
                              color:cubit.suppliersSelectedIndex == index
                                  ?secondaryColor.withOpacity(0.1):Colors.transparent,
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
                                  fontWeight: cubit.suppliersSelectedIndex == index
                                      ?FontWeight.bold:FontWeight.normal,
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
              // StreamBuilder<QuerySnapshot>(
              //   stream:
              //       FirebaseFirestore.instance.collection('orders').snapshots(),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<QuerySnapshot> snapshot) {
              //     if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     }
              //
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Text('Loading...');
              //     }
              //
              //     if (snapshot.hasData) {
              //       final orders = snapshot.data!.docs;
              //       print(orders[0].data());
              //
              //       return SizedBox(
              //         height: 30,
              //         width: double.infinity,
              //         child: ListView.builder(
              //           itemCount: orders.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             final order = orders[index];
              //             final orderUId = order.id;
              //             final orderData = order.data(); // Replace with your specific field names
              //             print(orderData);
              //             return ListTile(
              //               title: Text('Order ID: $orderUId'),
              //               subtitle: Text(
              //                   'Order data: $orderData'), // Replace with your specific field names
              //             );
              //           },
              //         ),
              //       );
              //     }
              //
              //     return Text('No orders found.');
              //   },
              // )

              StreamBuilder<List<UserModel>>(

                stream: cubit.suppliersSelectedIndex==0?cubit.allSuppliers():cubit.suppliers(categories[cubit.suppliersSelectedIndex].category),
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
                              /// Navigator to Technical Details Screen
                              press: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context){
                                    return TechnicalDetailsScreen(model: e,);
                                  }),
                                );
                              },
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
          ),
        );
      },
    );
  }
}
