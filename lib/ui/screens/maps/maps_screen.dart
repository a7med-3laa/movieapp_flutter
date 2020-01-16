import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:movieapp/resources/AppColors.dart';
import 'package:movieapp/ui/screens/maps/location_service.dart';
import 'package:movieapp/utils/Locale.dart';

class MapsScreen extends StatefulWidget {
  MapsScreen({Key key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    await getLocation();
  }

  getLoc(Location location) async {
    LocationData currentLocation;

    try {
      currentLocation = await location.getLocation();
      print("Location: " +
          currentLocation.longitude.toString() +
          "," +
          currentLocation.latitude.toString());
    } on PlatformException catch (e) {
      print("error " + e.code);
      if (e.code == 'PERMISSION_DENIED') {
        print('PERMISSION_DENIED');
      }
    }
    LatLng my = LatLng(currentLocation.latitude, currentLocation.longitude);
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 0,
      target: my,
      zoom: 19.4746,
    )));
    setState(() {
      markers.add(Marker(
        markerId: MarkerId('me'),
        position: my,
      ));
    });
  }

  getLocation() async {
    var location = new Location();

    if (await location.hasPermission() == true) {
      if (await location.serviceEnabled() == true) {
        getLoc(location);
      } else {
        if (await location.requestService() == true) getLoc(location);
      }
    } else {
      if (await location.requestPermission()) {
        if (await location.serviceEnabled() == true) {
          getLoc(location);
        } else {
          if (await location.requestService() == true) getLoc(location);
        }
      }
    }
  }

  Future<bool> canGetLocation() async {
    var location = new Location();

    return ((await location.hasPermission()) &&
        (await location.requestService()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: canGetLocation(),
        initialData: false,
        builder: (context, AsyncSnapshot<bool> canGetLocation) {
          if (canGetLocation.hasData) {
            if (canGetLocation.data) {
              return GoogleMap(
                mapType: MapType.hybrid,
                onMapCreated: _onMapCreated,
                markers: this.markers,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              );
            }
          }
          return Container(
            color: AppColors.COLOR_DARK_PRIMARY,
            child: Center(
                child: Text(
              appLocale.tr('Location_Error'),
              style: TextStyle(color: AppColors.TEXT_COLOR, fontSize: 15),
            )),
          );
        });
  }
}

//class MapsScreen extends StatelessWidget {
//  final Completer<GoogleMapController> _controller = Completer();
//  final LatLng _center = const LatLng(45.521563, -122.677433);
//  final Set<Marker> markers={};
//  void _onMapCreated(GoogleMapController controller) async {
//    _controller.complete(controller);
//    await getLocation();
//  }
//
//  getLoc(Location location) async {
//    LocationData currentLocation;
//
//    try {
//      currentLocation = await location.getLocation();
//      print("Location: " +
//          currentLocation.longitude.toString() +
//          "," +
//          currentLocation.latitude.toString());
//    } on PlatformException catch (e) {
//      print("error " + e.code);
//      if (e.code == 'PERMISSION_DENIED') {
//        print('PERMISSION_DENIED');
//      }
//    }
//    LatLng my= LatLng(currentLocation.latitude, currentLocation.longitude);
//    final GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//      bearing: 0,
//      target:my,
//      zoom: 14.4746,
//    )));
//
//    markers.add(Marker(markerId: MarkerId('me'),
//    position: my,
//
//    ));
//  }
//
//  getLocation() async {
//    var location = new Location();
//
//    if (await location.hasPermission() == true) {
//      if (await location.serviceEnabled() == true) {
//        getLoc(location);
//      } else {
//        if (await location.requestService() == true) getLoc(location);
//      }
//    } else {
//      if (await location.requestPermission()) {
//        if (await location.serviceEnabled() == true) {
//          getLoc(location);
//        } else {
//          if (await location.requestService() == true) getLoc(location);
//        }
//      }
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return GoogleMap(
//      mapType: MapType.hybrid,
//      onMapCreated: _onMapCreated,
//      markers: this.markers,
//      initialCameraPosition: CameraPosition(
//        target: _center,
//        zoom: 11.0,
//      ),
//    );
//  }
//}
