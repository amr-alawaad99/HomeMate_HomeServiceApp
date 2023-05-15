import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_register_methods/module/google_maps_widget/app_data.dart';
import 'package:login_register_methods/module/google_maps_widget/assistant_methods.dart';
import 'package:provider/provider.dart';

class GoogleMapsWidget extends StatefulWidget {
  bool isScrollable;
  bool isZoomable;
  bool isRotatable;

  GoogleMapsWidget(
      {required this.isScrollable,
      required this.isZoomable,
      required this.isRotatable,
      Key? key})
      : super(key: key);

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? _newGoogleMapController;

  static CameraPosition? _cameraPosition;

  LocationPermission? _locationPermission;

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.checkPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
      if (_locationPermission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (_locationPermission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  var geoLocator = Geolocator();
  Position? userCurrentPosition;
  static LatLng? _initialPosition;

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    userCurrentPosition = position;
    setState(() {
      _initialPosition =
          LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
      _cameraPosition =
          CameraPosition(target: _initialPosition as LatLng, zoom: 14.5);
      _newGoogleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition!));
    });
    await AssistantMethods.pickOriginPositionOnMap(_initialPosition!, context);
  }

  LatLng? onCameraMoveEndLatLng;
  Set<Circle> circleSet = {};

  Future<LatLng> pickLocationOnMap(CameraPosition onCameraMovePosition) async {
    LatLng onCameraMoveLatLng = onCameraMovePosition.target;
    Circle pinCircle = Circle(
      circleId: const CircleId("0"),
      radius: 1,
      zIndex: 1,
      strokeColor: Colors.black54,
      center: onCameraMoveLatLng,
      fillColor: Colors.blue.withAlpha(70),
    );
    circleSet.add(pinCircle);
    return onCameraMoveLatLng;
  }

  void _getPinnedAddress() async {
    onCameraMoveEndLatLng ??= _initialPosition!;
    await AssistantMethods.pickOriginPositionOnMap(
        onCameraMoveEndLatLng!, context);
  }

  @override
  void initState() {
    checkIfLocationPermissionAllowed();
    _getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final appData = Provider.of<AppData>(context);
    String originalAddress;
    if (appData.pinnedLocationOnMap != null) {
      originalAddress = appData.pinnedLocationOnMap!.placeName.toString();
    } else {
      originalAddress = "You Are Here...";
    }

    return Scaffold(
      body: _initialPosition == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    scrollGesturesEnabled: widget.isScrollable,
                    zoomGesturesEnabled: widget.isZoomable,
                    rotateGesturesEnabled: widget.isRotatable,
                    initialCameraPosition: _cameraPosition!,
                    zoomControlsEnabled: false,
                    circles: circleSet,
                    onCameraMove: (position) async {
                      onCameraMoveEndLatLng = await pickLocationOnMap(position);
                      print(onCameraMoveEndLatLng);
                    },
                    onCameraIdle: _getPinnedAddress,
                    gestureRecognizers: {
                      Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer())
                    },
                    onMapCreated: (controller) {
                      _controllerGoogleMap.complete(controller);
                      _newGoogleMapController = controller;
                    },
                  ),

                  /// PickUp Marker
                  Visibility(
                    child: Image.asset(
                      "assets/images/placeholder.png",
                      height: 40.0,
                      width: 40.0,
                      alignment: Alignment.center,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) =>
                              Transform.translate(
                        offset: const Offset(0, -20),
                        child: child,
                      ),
                    ),
                  ),

                  /// Show Location Text on GPS
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 10.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(35.0),
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: 1.0,
                                      style: BorderStyle.solid)),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  const Icon(
                                    Icons.my_location,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                      child: Text(
                                    originalAddress,
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
