import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:olx_clone/screens/home_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);
  static const String id = 'location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _loading = false;
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";

  Future<LocationData?> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    // setState(() async {
    _locationData = await location.getLocation();
    // });
    return _locationData;
  }

  @override
  Widget build(BuildContext context) {
    showBottomSheet(context) {
      showModalBottomSheet(
          isScrollControlled: true,
          enableDrag: true,
          context: context,
          builder: (context) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 26,
                  ),
                  AppBar(
                    elevation: 1,
                    automaticallyImplyLeading: false,
                    iconTheme: const IconThemeData(
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    title: Row(children: [
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Location',
                        style: TextStyle(color: Colors.black),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6)),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Search City, Area or Neighbourhood',
                            hintStyle: TextStyle(color: Colors.grey),
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    horizontalTitleGap: 8,
                    leading: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Use current location',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Enable Location',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 4, top: 4.0),
                        child: Text(
                          "CHOOSE CITY",
                          style: TextStyle(
                              color: Colors.blueGrey.shade900, fontSize: 12),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: CSCPicker(
                      layout: Layout.vertical,
                      defaultCountry: DefaultCountry.Pakistan,
                      dropdownDecoration:
                          const BoxDecoration(shape: BoxShape.rectangle),
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                          address =
                              '$cityValue, $stateValue, ${countryValue!.substring(8)}';
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          });
    }

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure you want to exit?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
        // return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(children: [
          Image.asset('assets/images/location.jpg'),
          const SizedBox(height: 20),
          const Text(
            'Please select your location',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          const Text(
            'Please, enalble your location service',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: _loading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                        )
                      : ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor)),
                          icon: const Icon(CupertinoIcons.location_fill),
                          label: const Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Text('Around me'),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            setState(() {
                              _loading = true;
                            });
                            getLocation().then((value) {
                              if (value != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomeScreen(
                                              _locationData,
                                            )));
                              }
                            });
                          },
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              showBottomSheet(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Set location manually',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
