import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';

  final LocationData locationData;
  HomeScreen(this.locationData);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'Pakistan';
  Future<String> getAddress() async {
    final coordinates = Coordinates(
        widget.locationData.latitude, widget.locationData.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      address = first.addressLine;
    });
    return first.addressLine;
  }

  @override
  void initState() {
    getAddress();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.location_solid,
                    color: Colors.black,
                    size: 18,
                  ),
                  Flexible(
                    child: Text(address,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.black,
                    size: 18,
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Center(
        // child: RaisedButton(
        //   onPressed: () {
        //     Navigator.pushNamed(context, LoginScreen.id);
        //   },
        child: Text('Login'),
        // ),
      ),
    );
  }
}
