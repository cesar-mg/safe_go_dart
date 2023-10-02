import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../Model/PermissionRequest.dart';

class SafeGoMap extends StatefulWidget {
  const SafeGoMap({super.key});

  @override
  State<SafeGoMap> createState() => SafeGoMapState();
}
  class SafeGoMapState extends State<SafeGoMap> {
  late GoogleMapController mapController;
  LatLng userLocation = const LatLng(0.0, 0.0);
  late PermissionRequest request;
  Location location = Location();
  @override
  void initState() {
    super.initState();
    init();
  }
  Future<void> init() async{
    PermissionRequest request = PermissionRequest();
    await request.requestLocationPermission(context);
    updateLocation();
  }
  updateLocation()  {
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        final latitude = currentLocation.latitude ?? 0.0;
        final longitude = currentLocation.longitude ?? 0.0;
        userLocation = LatLng(latitude, longitude);
        print(userLocation);
      });
    });
  }
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
      target: LatLng(4.6494863, -74.0538456), // Initial map center
      zoom: 12.0, // Initial zoom level
    ),
      markers: {
    Marker(
    markerId: const MarkerId('user_location'),
    position: userLocation,
      ),
      },
    );

  }
}
