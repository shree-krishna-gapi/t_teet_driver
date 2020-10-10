//library lite_rolling_switch;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:location/location.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Constants.dart';




class OnRide extends StatefulWidget {
  @override
  _OnRideState createState() => _OnRideState();
}

class _OnRideState extends State<OnRide> {

  Set<Marker> _markers = {};
//  Circle circle;
  GoogleMapController _controller;
  static final CameraPosition initialLocation =
  CameraPosition(
    target: LatLng(27.6667, 85.3500),
    zoom: 14.0,
  );

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(


      appBar: AppBar(
        title:  LiteRollingSwitch(
          value: true,
          textOn: 'Online',
          textOff: 'Offline',
          colorOn: AppColor.colorPrimary,
          colorOff: Colors.blueGrey,
          iconOn: Icons.lightbulb_outline,
          iconOff: Icons.power_settings_new,
          onChanged: (bool state) {
            print('turned ${(state) ? 'on' : 'off'}');
          },
        ),

        centerTitle: true,
        leading: Icon(Icons.person,color: Colors.grey[400],),

        actions: <Widget>[
          Padding(padding: EdgeInsets.only(right: 10.0), child: Icon(Icons.settings, color: Colors.black,)),
        ],
        backgroundColor: Colors.white,
      ),

      body: Stack(
          children: <Widget>[
            GoogleMap(

              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              cameraTargetBounds : CameraTargetBounds.unbounded,
              zoomControlsEnabled: false,
              initialCameraPosition: initialLocation,

              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;

              },


            ),
        Stack(
          children: <Widget>[
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: height * 0.35,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: new BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        alignment: Alignment.center,
                                        image: NetworkImage(
                                            Constants.PLACEHOLDER),
                                        fit: BoxFit.fill)),
                              )),
                          Column(

                            children: <Widget>[
                              Text(
                                "User's Name",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  )
                                  //as the rating
                                ],
                              )
                            ],
                          ),
                          Container(
                            width: 80,
                            height: height/25,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: AppColor.colorPrimary,
                              shape: BoxShape.rectangle,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.08,
                          ),
                          Icon(
                            Icons.radio_button_unchecked,
                            color: AppColor.colorPrimary,
                          ),
                          Text(
                            "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . ",
                            style: TextStyle(
                                color: AppColor.colorPrimary, fontSize: 18),
                          ),
                          Icon(
                            Icons.location_on,
                            color: AppColor.colorPrimary,
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Dropoff Location",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Bansbari, Chakrapath",
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                          SizedBox(
                            width: width * 0.08,
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: height * 0.08,
                            width: width * 0.7,
                            child: RaisedButton(
                                elevation: 0.0,
                                color: AppColor.colorPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(height* 0.1),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/invoice');
//


                                },
                                child: Text("Drop",
                                    style: new TextStyle(color: Colors.white, fontSize: 30.0))),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),





          ]),
    );
  }




  void getLocation() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) {
      print("location ${currentLocation.latitude} ${currentLocation.longitude}");
      _locationData = currentLocation;

      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(_locationData.latitude, _locationData.longitude),
      )));
    });
  }
}