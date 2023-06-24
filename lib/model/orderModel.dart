

class OrderModel{

  String? uId;
  String? userName;
  String? serviceName;
  String? date;
  String? time;
  String? notes;
  String? location;
  String? gpsLocation;
  String? status;
  String? cost;
  String? image;
  String? dateTimeForOrder;



  OrderModel({
    this.serviceName,
    this.date,
    this.time,
    this.notes,
    this.location,
    this.image,
    this.uId,
    this.status,
    this.userName,
    this.cost,
    this.dateTimeForOrder,


});
  OrderModel.fromJson(Map<String, dynamic> json){
    serviceName = json['serviceName'];
    uId = json['uId'];
    date = json['date'];
    time = json['time'];
    notes = json['notes'];
    location = json['location'];
    image = json['image'];
    status = json['status'];
    userName = json['userName'];
    cost = json['cost'];
    dateTimeForOrder = json['dateTimeForOrder'];
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
      'status': status,
      'userName': userName,
      'cost': cost,
      'dateTimeForOrder': dateTimeForOrder,

    };
  }
}