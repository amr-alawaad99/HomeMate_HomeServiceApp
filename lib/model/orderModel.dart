

class OrderModel{

  String? uId;
  String? profileName;
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
  String? orderUid;
  String? profilePic;
  String? technicalUId;



  OrderModel({
    this.serviceName,
    this.date,
    this.time,
    this.notes,
    this.location,
    this.image,
    this.uId,
    this.status,
    this.profileName,
    this.cost,
    this.dateTimeForOrder,
    this.gpsLocation,
    this.orderUid,
    this.profilePic,
    this.technicalUId,


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
    profileName = json['profileName'];
    cost = json['cost'];
    dateTimeForOrder = json['dateTimeForOrder'];
    gpsLocation = json['gpsLocation'];
    orderUid = json['orderUid'];
    profilePic = json['profilePic'];
    technicalUId = json['technicalUId'];
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
      'profileName': profileName,
      'cost': cost,
      'dateTimeForOrder': dateTimeForOrder,
      'gpsLocation': gpsLocation,
      'orderUid': orderUid,
      'profilePic': profilePic,
      'technicalUId': technicalUId,

    };
  }
}