class UserModel{
  String? uid;
  String? profileName;
  String? username;
  String? email;
  String? profilePic;
  String? address;
  String? gpsLocation;
  String? phoneNumber;
  String? serviceName;
  bool? isVerified;
  bool? isUser;

  UserModel({
    this.uid,
    this.profileName,
    this.username,
    this.email,
    this.profilePic,
    this.address,
    this.gpsLocation,
    this.phoneNumber,
    this.serviceName,
    this.isVerified,
    this.isUser,
});

  UserModel.fromJson(Map<String, dynamic> json){
    uid = json['uid'];
    profileName = json['profileName'];
    username = json['username'];
    email = json['email'];
    profilePic = json['profilePic'];
    address = json['address'];
    gpsLocation = json['gpsLocation'];
    phoneNumber = json['phoneNumber'];
    serviceName = json['serviceName'];
    isVerified = json['isVerified'];
    isUser = json['isUser'];
  }

  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'profileName' : profileName,
      'username' : username,
      'email' : email,
      'profilePic' : profilePic,
      'address' : address,
      'gpsLocation' : gpsLocation,
      'phoneNumber' : phoneNumber,
      'serviceName' : serviceName,
      'isVerified' : isVerified,
      'isUser' : isUser,
    };
  }


}