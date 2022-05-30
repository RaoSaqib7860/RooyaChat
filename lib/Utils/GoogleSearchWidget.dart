// import 'package:flutter/material.dart';
// import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
// import 'package:rooya/ApiConfig/BaseURL.dart';
//
// class GoogleSearchWidget extends StatefulWidget {
//   final Function(String)? adddress;
//   final Function(double)? lat;
//   final Function(double)? lng;
//
//   const GoogleSearchWidget({Key? key, this.adddress, this.lat, this.lng})
//       : super(key: key);
//
//   @override
//   _GoogleSearchWidgetState createState() => _GoogleSearchWidgetState();
// }
//
// class _GoogleSearchWidgetState extends State<GoogleSearchWidget> {
//   var predictions = <AutocompletePrediction>[];
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   final places = FlutterGooglePlacesSdk('$google_map_api_key');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.only(right: 20, left: 20, top: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: "Search",
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: Colors.black26,
//                       width: 1,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(
//                       color: Colors.black26,
//                       width: 0.5,
//                     ),
//                   ),
//                   labelStyle: TextStyle(color: Colors.black),
//                 ),
//                 onChanged: (value) async {
//                   if (value.isNotEmpty) {
//                     var p = await places.findAutocompletePredictions('$value');
//                     print('Result: $predictions');
//                     setState(() {
//                       predictions = p.predictions;
//                     });
//                   } else {
//                     if (predictions.length > 0 && mounted) {
//                       setState(() {
//                         predictions = [];
//                       });
//                     }
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: predictions.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: Icon(
//                         Icons.pin_drop,
//                         color: Colors.blueGrey,
//                       ),
//                       title: Text(
//                         predictions[index].fullText,
//                       ),
//                       onTap: () async {
//                         FetchPlaceResponse value =
//                             await places.fetchPlace(predictions[index].placeId);
//                         widget.adddress!(predictions[index].fullText);
//                         widget.lng!(value.place!.latLng!.lng);
//                         widget.lat!(value.place!.latLng!.lat);
//                         Navigator.of(context).pop();
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
