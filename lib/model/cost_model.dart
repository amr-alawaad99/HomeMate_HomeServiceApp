class OfferModel{
  String? cost;
  String? username;
  String? image;
  String? orderUId;
  String? offerUId;

  OfferModel({
    this.username,
    this.cost,
    this.image,
    this.orderUId,
    this.offerUId,
});

  OfferModel.fromJson(Map<String, dynamic> json){
    username = json['username'];
    cost = json['cost'];
    image = json['image'];
    orderUId = json['orderUId'];
    offerUId = json['offerUId'];
  }
  Map<String, dynamic> toMap(){
    return{
      'username':username,
      'cost':cost,
      'image':image,
      'orderUId':orderUId,
      'offerUId':offerUId,
    };
  }

}