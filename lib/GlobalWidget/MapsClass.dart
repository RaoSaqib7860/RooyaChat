import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/Utils/primary_color.dart';

class MapClass extends StatefulWidget {
  const MapClass({Key? key}) : super(key: key);

  @override
  _MapClassState createState() => _MapClassState();
}

class _MapClassState extends State<MapClass> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Position? position;

  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(position!.latitude, position!.longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
    final MarkerId markerId = MarkerId(UniqueKey().toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        position!.latitude,
        position!.longitude,
      ),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    super.initState();
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Share Location'),
        backgroundColor: buttonColor,
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: height / 2.30,
              width: width,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(markers.values),
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                SizedBox(
                  height: 5,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.blueGrey[50]!.withOpacity(0.5)),
                //   child: ListTile(
                //     leading: Icon(Icons.location_on_outlined),
                //     title: Text('Share Live location'),
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50]!.withOpacity(0.5)),
                  child: ListTile(
                    onTap: () {
                      Get.back(
                          result:
                              'latitude:${position!.latitude},longitude:${position!.longitude}');
                    },
                    leading: Icon(Icons.location_on_outlined),
                    title: Text('Share current location'),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
