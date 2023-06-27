class OfferModel{
  String? cost;
  String? profileName;
  String? uId;
  String? image;
  String? orderUId;
  String? offerUId;
  String? status;

  OfferModel({
    this.profileName,
    this.cost,
    this.image,
    this.orderUId,
    this.offerUId,
    this.uId,
    this.status,
});

  OfferModel.fromJson(Map<String, dynamic> json){
    profileName = json['profileName'];
    cost = json['cost'];
    image = json['image'];
    orderUId = json['orderUId'];
    offerUId = json['offerUId'];
    uId = json['uId'];
    status = json['status'];
  }
  Map<String, dynamic> toMap(){
    return{
      'profileName':profileName,
      'cost':cost,
      'image':image,
      'orderUId':orderUId,
      'offerUId':offerUId,
      'uId':uId,
      'status':status,
    };
  }

}