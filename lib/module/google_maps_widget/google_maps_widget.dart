import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/module/google_maps_widget/app_data.dart';
import 'package:login_register_methods/module/google_maps_widget/cubit/cubit.dart';
import 'package:login_register_methods/module/google_maps_widget/cubit/states.dart';
import 'package:login_register_methods/module/profile_screen/edit_profile_screen.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/resources/constants_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
    }
  }
}

class GoogleMapsWidget extends StatelessWidget {
  bool isEdit;

  GoogleMapsWidget(
      {this.isEdit = true,
      Key? key})
      : super(key: key);


  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

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


  @override
  Widget build(BuildContext context) {

    final appData = Provider.of<AppData>(context);
    String originalAddress;
    if (appData.pinnedLocationOnMap != null) {
      originalAddress = appData.pinnedLocationOnMap!.placeName.toString();
    } else {
      originalAddress = "You Are Here...";
    }

      return BlocProvider(
        create: (context) => GoogleMapsCubit()..checkIfLocationPermissionAllowed(),
        child: BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) async {
            if(state is GetUserDataSuccessState){
              await GoogleMapsCubit.get(context).getUserLocation(context);
            }
          },
          builder: (context, state) {
            return BlocConsumer<GoogleMapsCubit, GoogleMapsStates>(
              listener: (context, state) async {
                if(state is LocationPermissionAllowedState){
                  await GoogleMapsCubit.get(context).getUserLocation(context);
                  GoogleMapsCubit.get(context).getPinnedAddress(context);
                }
              },
              builder: (context, state) {
                var cubit = GoogleMapsCubit.get(context);
                if(cubit.locationPermission == LocationPermission.deniedForever || cubit.locationPermission == LocationPermission.denied) {
                  return SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(30.033333, 31.233334), zoom: 10.5)),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        TablerIcons.alert_circle,
                                        color: errorColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                        child: Text(
                                          "Location Permission Denied!",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
                                        ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                      openAppSettings();
                                      /// To Observe the change in permission after coming back from app settings
                                      WidgetsBinding.instance.addObserver(
                                          LifecycleEventHandler(
                                              resumeCallBack: () async => GoogleMapsCubit.get(context).checkIfLocationPermissionAllowed()
                                          ),
                                      );
                                    },
                                      child: Text("Settings",),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
                } else if(LayoutCubit.get(context).originalUser!.gpsLocation == '' && isEdit == false){
                  return SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(30.033333, 31.233334), zoom: 10.5)),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20.0)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Icon(
                                          TablerIcons.alert_circle,
                                          color: errorColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "You haven't set your location yet!",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          navigateAndPush(context, widget: EditProfileScreen());
                                        },
                                        child: Text("Edit",),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Scaffold(
                  body: cubit.initialPosition == null
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          myLocationButtonEnabled: isEdit,
                          myLocationEnabled: true,
                          scrollGesturesEnabled: isEdit,
                          zoomGesturesEnabled: isEdit,
                          rotateGesturesEnabled: isEdit,
                          initialCameraPosition: cubit.cameraPosition!,
                          zoomControlsEnabled: false,
                          circles: circleSet,
                          onCameraMove: (position) async {
                            cubit.onCameraMoveEndLatLng = await pickLocationOnMap(position);
                            print(cubit.onCameraMoveEndLatLng);
                          },
                          onCameraIdle: () {
                            cubit.getPinnedAddress(context);
                          },
                          gestureRecognizers: {
                            Factory<OneSequenceGestureRecognizer>(
                                    () => EagerGestureRecognizer())
                          },
                          onMapCreated: (controller) {
                            _controllerGoogleMap.complete(controller);
                            cubit.newGoogleMapController = controller;
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
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20.0)),
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
              },
            );
          },
        ),
      );
  }

}
