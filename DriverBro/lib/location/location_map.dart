// ignore_for_file: non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/screens/registration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'location_provider.dart';

class LocationMap extends StatefulWidget {
  final String phone, Driver, Bus, FS;

  LocationMap({this.phone, this.Bus, this.Driver, this.FS});
  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  bool g = true, a = false;
  DatabaseReference _ref;
  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _ref = FirebaseDatabase.instance.reference().child('BusData');
    Provider.of<LocationProvider>(context, listen: false).initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: const Text(
                  'stop sharing ??',
                  style: TextStyle(fontSize: 15.0),
                ),
                action: SnackBarAction(
                  label: 'Yes',
                  onPressed: () {
                    // Some code to undo the change.
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Registeration()));
                  },
                ),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0),
                    ),
                    Text(
                      "Sharing",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    )
                  ],
                ),
                Container(
                    height: 80.0,
                    width: 80.0,
                    child: Image.asset("assets/find bus (1).png")),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Driver",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    ),
                    Text(
                      "Bro",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          Container(
              height: 500,
              width: 380,
              decoration: new BoxDecoration(
                boxShadow: [
                  //background color of box
                  BoxShadow(
                    color: Colors.blue[300],
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: googleMapUI()),
          Container(
            height: 20,
          ),
          Vsg()
        ],
      ),
    );
  }

  Widget googleMapUI() {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      if (model.locationPosition != null) {
        return Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: model.locationPosition,
                  zoom: 18,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set<Marker>.of(model.markers.values),
                onMapCreated: (GoogleMapController controller) async {
                  Provider.of<LocationProvider>(context, listen: false)
                      .setMapController(controller);
                },
              ),
            ),
          ],
        );
      }

      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget Vsg() {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      if (model.locationPosition != null) {
        return Column(
          children: [
            Text(
              '${model.locationPosition}',
              style: TextStyle(
                  color: Colors.green[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              // ignore: deprecated_member_use
              child: FlatButton(
                  minWidth: double.infinity,
                  color: g == true ? Colors.black : Colors.grey,
                  onPressed: () {
                    void saveContact() {
                      String DriverName = widget.Driver;
                      String BusNumber = widget.Bus;
                      String PhoneNumber = widget.phone;
                      String FS = widget.FS;
                      double Lat = model.locationPosition.latitude;
                      double Lang = model.locationPosition.longitude;
                      Map<dynamic, dynamic> BusData = {
                        'DriverName': DriverName,
                        'BusNumber': BusNumber,
                        'PhoneNumber': '+91' + PhoneNumber,
                        'FS': FS,
                        'Lat': Lat,
                        'Lang': Lang,
                      };

                      _ref.push().set(BusData);
                    }

                    if (g == true) {
                      saveContact();
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: const Text(
                          'You are being tracked',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    setState(() {
                      g = false;
                    });
                  },
                  child: Text(
                    'SHARELOCATION',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  )),
            )
          ],
        );
      }

      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
