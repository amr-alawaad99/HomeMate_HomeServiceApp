

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingScreen extends StatelessWidget {
  final double lat;
  final double lng;
  const OrderTrackingScreen({required this.lat, required this.lng, super.key});



  @override
  Widget build(BuildContext context) {
    LatLng destination = LatLng(lat,lng);
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: destination, zoom: 14.5),
        gestureRecognizers: {
          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
        },
        markers: {
          Marker(
            markerId: MarkerId("source"),
            position: destination,
          ),
        },
      ),
    );
  }
}
