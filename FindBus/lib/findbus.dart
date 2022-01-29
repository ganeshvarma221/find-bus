// ignore_for_file: non_constant_identifier_names

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/location_map.dart';

// ignore: camel_case_types
class findBus extends StatefulWidget {
  @override
  _findBusState createState() => _findBusState();
}

// ignore: camel_case_types
class _findBusState extends State<findBus> {
  // ignore: unused_field
  Query _ref;
  DatabaseReference reference =
      // ignore: deprecated_member_use
      FirebaseDatabase.instance.reference().child('BusData');
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('BusData')
        .orderByChild('BusNumber');
  }

  Widget _BusCard({Map BusData}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[300],
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 80.0,
                width: 80.0,
                child: Image.asset("assets/find2.png")),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "BusNO",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                Text(
                  BusData['BusNumber'],
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                )
              ],
            ),
            Container(
              width: 10,
            ),
            Container(
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  border: Border.all(
                    color: Colors.black,
                    width: 1.4,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        BusData['FS'],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Icon(Icons.arrow_forward),
                      Text('MIC')
                    ],
                  ),
                )),
            Container(
              width: 20,
            ),
            Container(
              height: 50,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red[600]),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LocationMap()));
                    },
                    icon: Icon(
                      Icons.send,
                      size: 20.0,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Stack(
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
                      "Select",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0),
                    ),
                    Text(
                      "Your Bus",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )
                  ],
                ),
                Container(
                    height: 80.0,
                    width: 80.0,
                    child: Image.asset("assets/find.png")),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Find",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0),
                    ),
                    Text(
                      "Bus",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Container(
              height: double.infinity,
              child: FirebaseAnimatedList(
                query: _ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map BusData = snapshot.value;
                  BusData['key'] = snapshot.key;
                  return _BusCard(BusData: BusData);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
