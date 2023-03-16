import 'package:flutter/material.dart';


import '../../shared/components/components.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultCategoryChooser(text: 'Cleaning'),
        defaultAppointmentCard(context: context,
            serviceName: 'serviceName',
            userName: 'userName',
            date: 'date',
            time: 'time',
            status: 'status',
            cost: 'cost',
            count: 10),
      ],
    );
  }
}
