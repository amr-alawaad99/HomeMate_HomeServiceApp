import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/model/appointment.dart';
import 'package:login_register_methods/model/orderModel.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../sign_in_screen/cubit/cubit.dart';

class AppointmentsScreen extends StatelessWidget {
  List<Appointment> appointments = [
    Appointment(
      serviceName: 'Cleaning',
      userName: 'Mohamed',
      date: '21-10-2023',
      time: '12:50 AM',
      status: 'Finished',
      cost: '250 EGP',
      image: tempImage,
    ),
    Appointment(
      serviceName: 'Kitchen',
      userName: 'Ahmed',
      date: '21-10-2023',
      time: '12:50 AM',
      status: 'Underway',
      cost: '250 EGP',
      image: tempImage,
    ),
    Appointment(
      serviceName: 'Plumbing',
      userName: 'Ibrahim',
      date: '21-10-2023',
      time: '12:50 AM',
      status: 'Waiting Offers',
      cost: '250 EGP',
      image: tempImage,
    ),
    Appointment(
      serviceName: 'Paint',
      userName: 'Aly',
      date: '21-10-2023',
      time: '12:50 AM',
      status: 'Finished',
      cost: '250 EGP',
      image: tempImage,
    ),
    Appointment(
      serviceName: 'Carpentry',
      userName: 'Saad',
      date: '21-10-2023',
      time: '12:50 AM',
      status: 'Finished',
      cost: '250 EGP',
      image: tempImage,
    ),
    Appointment(
      serviceName: 'Electricity',
      userName: 'Mostafa',
      date: '21-10-2023',
      time: '12:50 AM',
      status: 'Finished',
      cost: '250 EGP',
      image: tempImage,
    ),
    Appointment(
      serviceName: 'Electricity',
      userName: 'Mohsen',
      date: '21-10-2023',
      time: '12:50 AM',
      status: 'Waiting Offers',
      cost: '320 EGP',
      image: tempImage,
    ),
  ];

  List<ChooseCategory> categories = [
    ChooseCategory(category: 'All'),
    ChooseCategory(category: 'Finished'),
    ChooseCategory(category: 'Underway'),
    ChooseCategory(category: 'Waiting'),
  ];

  List<Appointment> deleteItem(index) {
    appointments = List.from(index)..removeAt(index);
    return appointments;
  }

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
                    itemBuilder: (context, index) => InkWell(
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
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 8,
                        ),
                    itemCount: categories.length),
              ),
            ),
            ConditionalBuilder(
              condition: cubit.myOrders.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),

                    ///To avoid nested scrolling
                    shrinkWrap: true,
                    itemBuilder: (context, index) => defaultAppointmentCard(
                        model: cubit.myOrders[index], context: context),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: cubit.myOrders.length,
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator(color: primaryColor,)),
            ),
          ],
        );
      },
    );
  }

  Widget defaultAppointmentCard(
          {required OrderModel model, required context}) =>
      Container(
        padding: const EdgeInsets.all(10),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: SignInCubit.get(context).isDark
              ? Color(0xff303030)
              : Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: SignInCubit.get(context).isDark
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
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image(
                              image: NetworkImage(
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
                                "Amr",
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
                                    image: AssetImage('assets/images/star.png'),
                                    width: 15.0,
                                    height: 15.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '4.5/5',
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
                            "Status",
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cost',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        "cost",
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  TablerIcons.trash,
                                  color: errorColor,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  TablerIcons.edit,
                                  color: primaryColor,
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
            ),
          ],
        ),
      );
}
