import 'package:flutter/material.dart';

class OrderModel{
  String? serviceName;
  String? uId;

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
    this.uId,

});
  OrderModel.fromJson(Map<String, dynamic> json){
    serviceName = json['serviceName'];
    uId = json['uId'];
    date = json['date'];
    time = json['time'];
    notes = json['notes'];
    location = json['location'];

    image = json['image'];
  }
  Map<String, dynamic> toMap(){
    return {
      'serviceName': serviceName,
      'uId': uId,
      'date': date,
      'time': time,
      'notes': notes,
      'location': location,

      'image': image,
    };
  }
}