class UserModel{
  String? uid;
  String? firstName;
  String? lastName;
  String? username;
  String? profilePic;
  String? location;
  String? phoneNumber;
  bool? isVerified;
  bool? isUser;

  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.username,
    this.profilePic,
    this.location,
    this.phoneNumber,
    this.isVerified,
    this.isUser,
});

  UserModel.fromJson(Map<String, dynamic> json){
    uid = json['uid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilePic = json['profilePic'];
    location = json['location'];
    phoneNumber = json['phoneNumber'];
    isVerified = json['isVerified'];
    isUser = json['isUser'];
  }

  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'firstName' : firstName,
      'lastName' : lastName,
      'username' : username,
      'profilePic' : profilePic,
      'location' : location,
      'phoneNumber' : phoneNumber,
      'isVerified' : isVerified,
      'isUser' : isUser,
    };
  }


}