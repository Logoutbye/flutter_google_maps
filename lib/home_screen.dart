import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.19515897098909, 73.2353954824751),
    zoom: 14.4746,
  );

  // List<Marker> marker = [];
  final List<Marker> marker =<Marker> [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(34.19515897098909, 73.2353954824751),
      infoWindow: InfoWindow(title: "my office"),
    ),
    // Marker(
    //   markerId: MarkerId("2"),
    //   position: LatLng(34.189096, 73.233496),
    //   infoWindow: InfoWindow(title: "shoping"),
    // ),
    Marker(
      markerId: MarkerId("3"),
      position: LatLng(-33.83423940577346, 151.2079688640284),
      infoWindow: InfoWindow(title: "sydney"),
    ),
  ];

  Future<Position> getCurrentLocation ()async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) {
      print("error::$error");

    });
    return await Geolocator.getCurrentPosition();
  }
  // @override
  // void initState() {
  //   marker.addAll(list);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          markers: Set<Marker>.of(marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.local_airport_outlined),
        onPressed: () async {
          getCurrentLocation().then((value)async{
            print("objectobjectobject${value.latitude}:: ${value.longitude}");
            marker.add(Marker
              (markerId: MarkerId("2"),
                position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(
                title: "my current location"
              )
            ));
            CameraPosition cameraPosition =CameraPosition(
              zoom: 14,
                  // position: LatLng(-33.83423940577346, 151.2079688640284),

                target: LatLng(-33.83423940577346, 151.2079688640284));
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {

            });
          });


          //   const CameraPosition(
          //       target: LatLng(33.83423940577346, 151.2079688640284), zoom: 14),
          // ));
          // setState(() {});
        },
      ),
    );
  }
}
