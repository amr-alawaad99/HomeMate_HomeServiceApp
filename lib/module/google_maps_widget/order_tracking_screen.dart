
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng source = LatLng(31.04634216030081,31.36966221034527);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: source, zoom: 14.5),
        gestureRecognizers: {
          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
        },
        markers: {
          Marker(
            markerId: MarkerId("source"),
            position: source,
          ),
        },
      ),
    );
  }
}
