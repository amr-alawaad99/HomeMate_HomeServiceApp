import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/model/appointment.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

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
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
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
                                    color:
                                        cubit.appointmentSelectedIndex == index
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),

                    ///To avoid nested scrolling
                    shrinkWrap: true,
                    itemBuilder: (context, index) => defaultAppointmentCard(
                      onTap: (){

                      },
                      serviceName: appointments[index].serviceName!,
                      userName: appointments[index].userName!,
                      date: appointments[index].date!,
                      time: appointments[index].time!,
                      status: appointments[index].status!,
                      statusColor: appointments[index].status == 'Finished'?successColor:warningColor,
                      cost: appointments[index].cost!,
                      image: appointments[index].image!,
                      iconColor: (appointments[index].status == 'Finished')
                          ? successColor
                          : warningColor,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: appointments.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
