import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_register_methods/model/address_model.dart';
import 'package:login_register_methods/module/google_maps_widget/app_data.dart';
import 'package:provider/provider.dart';

class AssistantMethods{

  static Future<Uint8List> getMaker(String fileName, context) async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/$fileName.png");
    return byteData.buffer.asUint8List();
  }
  //*******************************************************************************************//
  static Future<String> pickOriginPositionOnMap(LatLng position, context) async{
    String placeAddress = '';
    //Geocoding consts
    String province = '';
    String locality = '';
    String name = '';
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if(placemarks.isNotEmpty){
      province = placemarks[0].country == null? " " : placemarks[0].administrativeArea!;
      locality = placemarks[0].locality == null? " " : placemarks[0].locality!;
      name = placemarks[0].name == null? " " : placemarks[0].name!;
      placeAddress = "$name, $locality, $province";
    }
    Address userPickupAddress = Address();
    userPickupAddress.latitude = position.latitude;
    userPickupAddress.longitude = position.longitude;
    userPickupAddress.placeName = placeAddress;
    Provider.of<AppData>(context, listen: false).updatePickupLocationAddress(userPickupAddress);
    return placeAddress;
  }
}