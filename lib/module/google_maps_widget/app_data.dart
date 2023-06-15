import 'package:flutter/cupertino.dart';
import 'package:login_register_methods/model/address_model.dart';

class AppData extends ChangeNotifier{
  Address? pinnedLocationOnMap;


  void updatePickupLocationAddress(Address pickupAddress){
    pinnedLocationOnMap = pickupAddress;
    notifyListeners();
  }


}