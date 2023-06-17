import 'package:flutter/material.dart';

class OrderModel{
  String? serviceName;
  String? date;
  String? time;
  String? notes;
  String? location;
  ImageProvider? image;

  OrderModel({
    this.serviceName,
    this.date,
    this.time,
    this.notes,
    this.location,
    this.image,
});
  OrderModel.fromJson(Map<String, dynamic> json){
    serviceName = json['serviceName'];
    date = json['date'];
    time = json['time'];
    notes = json['notes'];
    location = json['location'];
    image = json['image'];
  }
  Map<String, dynamic> toMap(){
    return {
      'serviceName': serviceName,
      'date': date,
      'time': time,
      'notes': notes,
      'location': location,
      'image': image,
    };
  }
}