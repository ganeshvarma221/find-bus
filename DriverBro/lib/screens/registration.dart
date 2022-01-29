import 'package:flutter/material.dart';
import 'package:flutter_live_location_gmap/screens/otp.dart';

class Registeration extends StatefulWidget {
  @override
  _RegisterationState createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phone = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _Driver = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _Bus = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _FS = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                child: ListView(
                  children: [
                    Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0),
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
                      height: 50,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Driver name',
                                    fillColor: Colors.black,
                                    hoverColor: Colors.black),
                                controller: _Driver,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              Container(
                                height: 10.0,
                              ),
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Bus Number',
                                ),
                                keyboardType: TextInputType.number,
                                controller: _Bus,

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              Container(
                                height: 10.0,
                              ),
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                decoration: const InputDecoration(
                                  prefix: Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text("+91"),
                                  ),
                                  labelText: 'phone number',
                                  border: OutlineInputBorder(),
                                ),
                                controller: _phone,
                                maxLength: 10,
                                keyboardType: TextInputType.number,

                                validator: (value) {
                                  if (value.length != 10 || value.isEmpty) {
                                    return 'plz enter valid ph number';
                                  }
                                  return null;
                                },
                              ),
                              Container(
                                height: 10.0,
                              ),
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                decoration: const InputDecoration(
                                  labelText: 'From Station',
                                  border: OutlineInputBorder(),
                                ),
                                controller: _FS,

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'this should be not empty';
                                  }
                                  return null;
                                },
                              ),
                              Container(
                                height: 10.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  minWidth: double.infinity,
                                  color: Colors.blue,
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Otp(
                                                  phone: _phone.text,
                                                  Driver: _Driver.text,
                                                  Bus: _Bus.text,
                                                  FS: _FS.text)));
                                    }
                                  },
                                  child: const Text(
                                    'REGISTER',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
