class SupplierModel {
  String? userName;
  String? serviceName;
  String? location;
  String? image;


  SupplierModel({
    this.serviceName,
    this.location,
    this.image,
    this.userName,
  });

  SupplierModel.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    location = json['location'];
    image = json['image'];
    userName = json['userName'];

  }

  Map<String, dynamic> toMap() {
    return {
      'serviceName': serviceName,
      'location': location,
      'image': image,
      'userName': userName,

    };
  }
}
