import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/model/appointment.dart';
import 'package:login_register_methods/model/orderModel.dart';
import 'package:login_register_methods/shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../appointment_details/appointment_detials_screen.dart';
import '../sign_in_screen/cubit/cubit.dart';

class AppointmentsScreen extends StatelessWidget {
  // List<Appointment> appointments = [
  //   Appointment(
  //     serviceName: 'Cleaning',
  //     userName: 'Mohamed',
  //     date: '21-10-2023',
  //     time: '12:50 AM',
  //     status: 'Finished',
  //     cost: '250 EGP',
  //     image: tempImage,
  //   ),
  //   Appointment(
  //     serviceName: 'Kitchen',
  //     userName: 'Ahmed',
  //     date: '21-10-2023',
  //     time: '12:50 AM',
  //     status: 'Underway',
  //     cost: '250 EGP',
  //     image: tempImage,
  //   ),
  //   Appointment(
  //     serviceName: 'Plumbing',
  //     userName: 'Ibrahim',
  //     date: '21-10-2023',
  //     time: '12:50 AM',
  //     status: 'Waiting Offers',
  //     cost: '250 EGP',
  //     image: tempImage,
  //   ),
  //   Appointment(
  //     serviceName: 'Paint',
  //     userName: 'Aly',
  //     date: '21-10-2023',
  //     time: '12:50 AM',
  //     status: 'Finished',
  //     cost: '250 EGP',
  //     image: tempImage,
  //   ),
  //   Appointment(
  //     serviceName: 'Carpentry',
  //     userName: 'Saad',
  //     date: '21-10-2023',
  //     time: '12:50 AM',
  //     status: 'Finished',
  //     cost: '250 EGP',
  //     image: tempImage,
  //   ),
  //   Appointment(
  //     serviceName: 'Electricity',
  //     userName: 'Mostafa',
  //     date: '21-10-2023',
  //     time: '12:50 AM',
  //     status: 'Finished',
  //     cost: '250 EGP',
  //     image: tempImage,
  //   ),
  //   Appointment(
  //     serviceName: 'Electricity',
  //     userName: 'Mohsen',
  //     date: '21-10-2023',
  //     time: '12:50 AM',
  //     status: 'Waiting Offers',
  //     cost: '320 EGP',
  //     image: tempImage,
  //   ),
  // ];

  final List<ChooseCategory> categories = [
    ChooseCategory(category: 'All'),
    ChooseCategory(category: 'Finished'),
    ChooseCategory(category: 'Underway'),
    ChooseCategory(category: 'Waiting'),
  ];

  // List<Appointment> deleteItem(index) {
  //   appointments = List.from(index)..removeAt(index);
  //   return appointments;
  // }

  AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
              ),
              child: SizedBox(
                height: 30,
                width: double.infinity,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        InkWell(
                          onTap: () {
                            cubit.changeAppointmentIndex(index);
                          },
                          child: Container(
                            width: 90,
                            height: 100,
                            decoration: BoxDecoration(
                              border: cubit.appointmentSelectedIndex == index
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
                                  color: cubit.appointmentSelectedIndex == index
                                      ? secondaryColor
                                      : Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) =>
                    const SizedBox(
                      width: 8,
                    ),
                    itemCount: categories.length),
              ),
            ),

            Column(
              children: [
                StreamBuilder<List<OrderModel>>(
                  stream: cubit.orders(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error No Data found! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final orders = snapshot.data!.reversed;
                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: orders
                            .map(
                              (e) =>
                              defaultAppointmentCard(
                                  model: e,
                                  context: context,
                                  onTap: () {
                                    navigateAndPush(context,
                                        widget: AppointmentDetails(
                                           model: e,
                                          ));
                                  }
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
          ],
        );
      },
    );
  }

  Widget defaultAppointmentCard(
      {required OrderModel model, required context, Function()? onTap}) =>
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 150,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              color: SignInCubit
                  .get(context)
                  .isDark
                  ? Color(0xff303030)
                  : Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: SignInCubit
                      .get(context)
                      .isDark
                      ? Colors.transparent
                      : Colors.black12,
                  blurRadius: 20.0,
                  offset: Offset(0.0, 0.75),
                ),
              ],
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.serviceName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image(
                                    image: NetworkImage(LayoutCubit
                                        .get(context)
                                        .originalUser!
                                        .isUser == false ? model.image! :
                                    "https://img.freepik.com/free-vector/self-care-concept_23-2148523717.jpg?w=740&t=st=1678538562~exp=1678539162~hmac=a7d5a1db32b0d9a70e2ebbf68ab260a7ff455a23edb61284689ea8c3559233dd"),
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(

                                      LayoutCubit
                                          .get(context)
                                          .originalUser!
                                          .isUser == false
                                          ? model.userName!
                                          : 'waiting for technical offers!',
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: const [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/star.png'),
                                          width: 15.0,
                                          height: 15.0,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '??/5',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.date!,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                model.time!,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                TablerIcons.circle,
                                size: 20,
                                color: successColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                model.status!,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: errorColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Ex.Cost',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          model.cost!,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    LayoutCubit.get(context).removeOrder(orderUid: model.orderUid!);
                                  },
                                  child: Icon(
                                    TablerIcons.trash,
                                    color: errorColor,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
