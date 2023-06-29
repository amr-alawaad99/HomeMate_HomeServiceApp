import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_register_methods/module/google_maps_widget/cubit/states.dart';

import '../../../layout/cubit/cubit.dart';
import '../assistant_methods.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsStates>{

  GoogleMapsCubit() : super(GoogleMapsInitState());

  static GoogleMapsCubit get(context) => BlocProvider.of(context);


  LocationPermission? locationPermission;
  checkIfLocationPermissionAllowed() async {
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        emit(LocationPermissionDeniedState());
        return Future.error('Location permissions are denied');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      emit(LocationPermissionDeniedForeverState());
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } else {
      emit(LocationPermissionAllowedState());
    }
  }




  var geoLocator = Geolocator();
  Position? userCurrentPosition;
  LatLng? initialPosition;


  GoogleMapController? newGoogleMapController;

  CameraPosition? cameraPosition;


  getUserLocation(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    userCurrentPosition = position;
    //
    if (LayoutCubit.get(context).originalUser!.gpsLocation == '') {
      initialPosition = LatLng(
          userCurrentPosition!.latitude, userCurrentPosition!.longitude);
    } else {
      List<String> location = LayoutCubit.get(context).originalUser!.gpsLocation!.split(',');
      double latitude = double.parse(location[0]);
      double longitude = double.parse(location[1]);
      initialPosition = LatLng(latitude, longitude);
    }
    cameraPosition =
        CameraPosition(target: initialPosition as LatLng, zoom: 14.5);
    newGoogleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition!));
    //
    await AssistantMethods.pickOriginPositionOnMap(initialPosition!, context);

    emit(GetUserLocationSuccessState());
  }




  LatLng? onCameraMoveEndLatLng;

  void getPinnedAddress(BuildContext context) async {
    onCameraMoveEndLatLng ??= initialPosition!;
    await AssistantMethods.pickOriginPositionOnMap(
        onCameraMoveEndLatLng!, context);
    LayoutCubit.get(context).updateCurrentPositionOnGPS(
        "${onCameraMoveEndLatLng!.latitude},${onCameraMoveEndLatLng!.longitude}");

    emit(GetPinnedAddressSuccessState());
  }
}