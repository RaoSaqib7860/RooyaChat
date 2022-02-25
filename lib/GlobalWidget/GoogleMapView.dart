import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  final String? lat;
  final String? lng;
  final Function()? ontap;

  const GoogleMapView({Key? key, this.lat, this.lng, this.ontap})
      : super(key: key);

  @override
  _GoogleMapViewState createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition? kGooglePlex;

  @override
  void initState() {
    kGooglePlex = CameraPosition(
      target: LatLng(double.parse(widget.lat!), double.parse(widget.lng!)),
      zoom: 14.4746,
    );
    final MarkerId markerId = MarkerId(UniqueKey().toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(double.parse(widget.lat!), double.parse(widget.lng!)),
    );
    markers[markerId] = marker;
    super.initState();
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: GoogleMap(
        mapType: MapType.normal,
        onTap: (LatLng latLng) {
          widget.ontap!.call();
        },
        zoomControlsEnabled: false,
        initialCameraPosition: kGooglePlex!,
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}
