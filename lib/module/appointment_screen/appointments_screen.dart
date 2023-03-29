import 'package:flutter/material.dart';
import 'package:login_register_methods/models/appointment.dart';

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
      status: 'Waiting',
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: SizedBox(
              height: 30,
              width: double.infinity,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: Container(
                          width: 95,
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
                                fontSize: 20,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 90),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => defaultAppointmentCard(
                  serviceName: appointments[index].serviceName,
                  userName: appointments[index].userName,
                  date: appointments[index].date,
                  time: appointments[index].time,
                  status: appointments[index].status,
                  cost: appointments[index].cost,
                  image: appointments[index].image,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: appointments.length,
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
