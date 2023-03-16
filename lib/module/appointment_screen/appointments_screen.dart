import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Container(
            width: double.infinity,
            height: 30,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) =>
                  defaultCategoryChooser(text: 'Cleaning'),
              separatorBuilder: (context, index) => SizedBox(
                width: 5,
              ),
              itemCount: 6,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: defaultAppointmentCard(
              serviceName: 'Service',
              userName: 'User',
              date: 'date',
              time: 'time',
              status: 'status',
              cost: 'Cost EGP',
              count: 10,
            ),
          ),
        ),
      ],
    );
  }
}
