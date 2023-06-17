import 'package:flutter/material.dart';

class Appointment {
  String? serviceName;
  String? userName;
  String? date;
  String? time;
  String? status;
  String? cost;
  ImageProvider? image;

  Appointment(
      {this.serviceName,
      this.userName,
      this.date,
      this.time,
      this.status,
      this.cost,
      this.image});

  Appointment.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    userName = json['userName'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    cost = json['cost'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceName': serviceName,
      'userName': userName,
      'date': date,
      'time': time,
      'status': status,
      'cost': cost,
      'image': image,
    };
  }
}

class ChooseCategory {
  final String category;

  ChooseCategory({required this.category});
}
