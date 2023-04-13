import 'package:flutter/material.dart';

class Appointment {
  final String serviceName;
  final String userName;
  final String date;
  final String time;
  final String status;
  final String cost;
  final ImageProvider image;

  Appointment({
    required this.serviceName,
    required this.userName,
    required this.date,
    required this.time,
    required this.status,
    required this.cost,
    required this.image
  });


}
class ChooseCategory{
  final String category;

  ChooseCategory({
    required this.category
});
}
