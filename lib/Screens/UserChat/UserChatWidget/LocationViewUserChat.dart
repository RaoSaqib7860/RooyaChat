import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rooya/ApiConfig/SizeConfiq.dart';
import 'package:rooya/GlobalWidget/GoogleMapView.dart';
import 'package:rooya/GlobalWidget/SnackBarApp.dart';

class LocationViewUserChat extends StatefulWidget {
  final bool? right;
  const LocationViewUserChat({Key? key, this.right = true}) : super(key: key);

  @override
  _LocationViewUserChatState createState() => _LocationViewUserChatState();
}

class _LocationViewUserChatState extends State<LocationViewUserChat> {
  @override
  Widget build(BuildContext context) {
    if (widget.right!) {
      return Builder(builder: (context) {
        // List list = '${getcontroller!.oneToOneChat[i].message!.message}'.split(',');
        List list = [];
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: width,
            height: height * 0.210,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(color: Colors.blueGrey[50]),
            child: GoogleMapView(
              lat: list[0].toString().split(':')[1],
              lng: list[1].toString().split(':')[1],
              ontap: () async {
                print('Clicked on map');
                Position? position = await Geolocator.getLastKnownPosition();
                launchURL(
                    'https://www.google.com/maps/dir/?api=1&origin=${position!.latitude},${position.longitude}&destination=${list[0].toString().split(':')[1]},${list[1].toString().split(':')[1]}&travelmode=driving&dir_action=navigate');
              },
            ),
          ),
        );
      });
    } else {
      return Builder(builder: (context) {
        // List list = '${getcontroller!.oneToOneChat[i].message!.message}'.split(',');
        List list = [];
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: width,
            height: height * 0.210,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(color: Colors.blueGrey[50]),
            child: GoogleMapView(
              lat: list[0].toString().split(':')[1],
              lng: list[1].toString().split(':')[1],
              ontap: () async {
                print('Clicked on map');
                Position? position = await Geolocator.getLastKnownPosition();
                launchURL(
                    'https://www.google.com/maps/dir/?api=1&origin=${position!.latitude},${position.longitude}&destination=${list[0].toString().split(':')[1]},${list[1].toString().split(':')[1]}&travelmode=driving&dir_action=navigate');
              },
            ),
          ),
        );
      });
    }
  }
}
