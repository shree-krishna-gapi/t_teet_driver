// library lite_rolling_switch;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:t_teet_rider/rider/screen/home/drawer.dart';
import 'package:t_teet_rider/screens/BottomBar.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Constants.dart';
import 'package:t_teet_rider/utils/PushNotificationService.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: <Widget>[
//        BottomNavBar(),
        GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          cameraTargetBounds: CameraTargetBounds.unbounded,
          zoomControlsEnabled: false,
          initialCameraPosition: initialLocation,
          markers: _markers,
          polylines: _polylines,
          onMapCreated: onMapCreated,
        ),

        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              hideNotice();
            },
            child: Visibility(
              visible: _isVisible,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0))),
                  height: height / 4,
                  width: width,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Travel responsibly",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                              "Help keep our communities safe as we navigate this together.",
                              style: TextStyle(color: Colors.white)),
                          SizedBox(height: 20.0),
                          Row(
                            children: <Widget>[
                              Text("Stay informed",
                                  style: TextStyle(color: Colors.white)),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 18.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),

//            BottomModalHome(),
      ]),
    );
  }
}

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  List<MyData> allData = [];
  String name,
      profile,
      city,
      email,
      gender,
      phone,
      vehicleModel,
      vehicleName,
      vehicleNumber,
      vehicleYear,
      licenseNumber,
      licensePhoto,
      licenseExpiryDate,
      blueNookFrontPhoto,
      blueBookBackPhoto;
  bool userVechiclePublicOrPrivate;

//  Circle circle;
  GoogleMapController _controller;
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(27.6667, 85.3500),
    zoom: 14.0,
  );

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  bool _isVisible = true;



  BitmapDescriptor maleIcon,femaleIcon;

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/male.png').then((onValue) {
      maleIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/female.png').then((onValue) {
      femaleIcon = onValue;
    });
    ref.once().then((DataSnapshot snap) {

      var keys = snap.value.keys;
      var data = snap.value;
      for(var key in keys) {
        if(data[key]['gender'] == 'male') {
          setState(() {
            _markers.add(
                Marker(
                    markerId: MarkerId(key),
                    position: LatLng(data[key]['lat'],data[key]['lng']),
                    icon: maleIcon, onTap:()=>_getPolyline(data[key]['lat'],data[key]['lng'])
                )
            );
          });
        } else {
          _markers.add(
              Marker(
                  markerId: MarkerId(key),
                  position: LatLng(data[key]['lat'],data[key]['lng']),
                  icon: femaleIcon, onTap:()=>_getPolyline(data[key]['lat'],data[key]['lng'])
              )
          );
        }

      }
    });

    PushNotificationService().init(context);
    getLocation();
    initialize();
    super.initState();
  }

  void hideNotice() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  Set<Marker> _markers = {
  };

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    var heightback;
    if (height <= 650) {
      heightback = height * 0.37;
    } else {
      heightback = height * 0.28;
    }
    bool connected = true;

    return Scaffold(
      bottomNavigationBar: BottomBar(),
      key: _drawerKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {

          },
          child: Icon(
            Icons.supervised_user_circle,
            color: AppColor.colorPrimary,
          ),
        ),
        title: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: connected ? AppColor.onLineColor : AppColor.offLineColor,
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.colorPrimary.withOpacity(0.02),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(22),
            ),
            child: GestureDetector(
              onTap: () {
                return Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: connected
                          ? AppColor.onLineColor
                          : AppColor.offLineColor,
                      width: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.colorPrimary.withOpacity(0.02),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                          decoration: BoxDecoration(
                            color: AppColor.offLineColor,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Offline',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              )),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: connected
                          ? AppColor.onLineColor
                          : AppColor.offLineColor,
                      width: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.colorPrimary.withOpacity(0.02),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3.0),
                          decoration: BoxDecoration(
                            color: AppColor.onLineColor,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Online',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              )),
                        ),
                        flex: 1,
                      ),
                    ],
                  )),
            ),
            width: 180,
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              _drawerKey.currentState.openDrawer();
//              dwa
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset(
                'assets/images/customMenu.png',
                width: 24,
                fit: BoxFit.fitWidth,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerPage(tag: 'Home'),
      ),
      body: Stack(children: <Widget>[
//        BottomNavBar(),
        GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          cameraTargetBounds: CameraTargetBounds.unbounded,
          zoomControlsEnabled: false,
          initialCameraPosition: initialLocation,
          markers: _markers,
          polylines: Set<Polyline>.of(polylines.values),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;


          },
        ),

        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              hideNotice();
            },
            child: Visibility(
              visible: _isVisible,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0))),
                  height: height / 4,
                  width: width,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Travel responsibly",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                              "Help keep our communities safe as we navigate this together.",
                              style: TextStyle(color: Colors.white)),
                          SizedBox(height: 20.0),
                          Row(
                            children: <Widget>[
                              Text("Stay informed",
                                  style: TextStyle(color: Colors.white)),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 18.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),

//            BottomModalHome(),
      ]),
    );
  }

  showNotificationDetailForeground(BuildContext context) {
    String title = "title";
    String body = "body";
    String notificationId = "id";
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
//    NotificationRepository().markNotificaions(notificationId);
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(title),
          content: Container(
            child: Column(children: <Widget>[
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: height * 0.50,
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
                                          image:
                                          NetworkImage(Constants.PLACEHOLDER),
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
                              height: 80,
                              decoration: new BoxDecoration(
                                color: AppColor.colorPrimary,
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.radio_button_unchecked,
                              color: AppColor.colorPrimary,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Pickup Location"),
                                Text("Bansbari, Chakrapath")
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Travel Distance"),
                                Text("8.6Km")
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: AppColor.colorPrimary,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Dropoff Location"),
                                Text("Bansbari, Chakrapath")
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Rider Distance"),
                                Text("1.6Km")
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: 1.0,
                            width: width * 0.95,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Payment : Cash",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Nrs. 120.00",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
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
                              height: height / 15.5,
                              width: width / 2.5,
                              child: RaisedButton(
                                  elevation: 0.0,
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(height * 0.1),
                                  ),
                                  onPressed: () {},
                                  child: Text("Reject",
                                      style:
                                      new TextStyle(color: Colors.white))),
                            ),
                            Container(
                              height: height / 15.5,
                              width: width / 2.5,
                              child: RaisedButton(
                                  elevation: 0.0,
                                  color: AppColor.colorPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(height * 0.1),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return Container(
                                            width: width,
                                            height: height / 2.5,
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                        width: width * 0.08),
                                                    Container(
                                                        child: Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: new BoxDecoration(
                                                              color: Colors.grey,
                                                              shape:
                                                              BoxShape.circle,
                                                              image: DecorationImage(
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  image: NetworkImage(
                                                                      Constants
                                                                          .PLACEHOLDER),
                                                                  fit:
                                                                  BoxFit.fill)),
                                                        )),
                                                    SizedBox(
                                                        width: width * 0.08),
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          "User's Name",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                        SizedBox(
                                                          width: width / 5,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: width * 0.08,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .radio_button_unchecked,
                                                      color:
                                                      AppColor.colorPrimary,
                                                    ),
                                                    Text(
                                                      "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . ",
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .colorPrimary,
                                                          fontSize: 18),
                                                    ),
                                                    Icon(
                                                      Icons.location_on,
                                                      color:
                                                      AppColor.colorPrimary,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: width * 0.08,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "Pickup Location",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                        Text(
                                                          "Bansbari, Chakrapath",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black,
                                                              fontSize: 18),
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
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  children: <Widget>[
                                                    Container(
                                                      height: height / 15.5,
                                                      width: width / 2.5,
                                                      child: RaisedButton(
                                                          elevation: 0.0,
                                                          color: Colors.red,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                height *
                                                                    0.1),
                                                          ),
                                                          onPressed: () {
//                                                                showAlertDialog(context);
                                                          },
                                                          child: Text(
                                                              "Cancel request",
                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .white))),
                                                    ),
                                                    Container(
                                                      height: height / 15.5,
                                                      width: width / 2.5,
                                                      child: RaisedButton(
                                                          elevation: 0.0,
                                                          color: AppColor
                                                              .colorPrimary,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                height *
                                                                    0.1),
                                                          ),
                                                          onPressed: () {
                                                            showModalBottomSheet(
                                                                context:
                                                                context,
                                                                builder:
                                                                    (builder) {
                                                                  return Container(
                                                                    width:
                                                                    width,
                                                                    height:
                                                                    height /
                                                                        2.5,
                                                                    child:
                                                                    Column(
                                                                      children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                          height:
                                                                          height * 0.02,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                          children: <
                                                                              Widget>[
                                                                            SizedBox(width: width * 0.08),
                                                                            Container(
                                                                                child: Container(
                                                                                  width: 80,
                                                                                  height: 80,
                                                                                  decoration: new BoxDecoration(color: Colors.grey, shape: BoxShape.circle, image: DecorationImage(alignment: Alignment.center, image: NetworkImage(Constants.PLACEHOLDER), fit: BoxFit.fill)),
                                                                                )),
                                                                            SizedBox(width: width * 0.08),
                                                                            Column(
                                                                              children: <Widget>[
                                                                                SizedBox(width: width * 0.08),
                                                                                Text(
                                                                                  "User's Name",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: width / 5,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                          height * 0.02,
                                                                        ),
                                                                        Row(
                                                                          children: <
                                                                              Widget>[
                                                                            SizedBox(
                                                                              width: width * 0.08,
                                                                            ),
                                                                            Icon(
                                                                              Icons.radio_button_unchecked,
                                                                              color: AppColor.colorPrimary,
                                                                            ),
                                                                            Text(
                                                                              "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . ",
                                                                              style: TextStyle(color: AppColor.colorPrimary, fontSize: 18),
                                                                            ),
                                                                            Icon(
                                                                              Icons.location_on,
                                                                              color: AppColor.colorPrimary,
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                          height * 0.02,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.end,
                                                                          children: <
                                                                              Widget>[
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: <Widget>[
                                                                                Text(
                                                                                  "Dropoff Location",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w500),
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
                                                                          height:
                                                                          height * 0.02,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                          height * 0.02,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                          height * 0.02,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.spaceAround,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              height: height / 15.5,
                                                                              width: width / 2.5,
                                                                              child: RaisedButton(
                                                                                  elevation: 0.0,
                                                                                  color: Colors.red,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(height * 0.1),
                                                                                  ),
                                                                                  onPressed: () {
//                                                                                        showAlertDialog(context);
                                                                                  },
                                                                                  child: Text("Cancel request", style: new TextStyle(color: Colors.white))),
                                                                            ),
                                                                            Container(
                                                                              height: height / 15.5,
                                                                              width: width / 2.5,
                                                                              child: RaisedButton(
                                                                                  elevation: 0.0,
                                                                                  color: AppColor.colorPrimary,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(height * 0.1),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.pushNamed(context, '/onride');
//
                                                                                  },
                                                                                  child: Text("Pick Up", style: new TextStyle(color: Colors.white))),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: Text("Arrived",
                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .white))),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text("Accept",
                                      style:
                                      new TextStyle(color: Colors.white))),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ]),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () =>
                  Navigator.of(buildContext, rootNavigator: true).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: AppColor.colorPrimary),
              ),
            )
          ],
        );
      },
    );

//    return BottomModalHome();
  }
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.purple, points: polylineCoordinates,width: 3);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline(double slat, double slang) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBdeTQAqqsYBvAei69ZI1eV70Bk-M7hUgQ',
      PointLatLng(slat, slang),
      PointLatLng(27.7123261,85.3265372),
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
  void getLocation() async {
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
//      print("location ${currentLocation.latitude} ${currentLocation.longitude}");
      _locationData = currentLocation;
      sendRiderData(currentLocation);
      /*_controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(_locationData.latitude, _locationData.longitude),
     zoom: 14.0,
     )));*/
    });
  }

  Firestore firestore;

  initialize() async {
    getFirestoreInstance().then((value) {
      firestore = value;
      getProfileData();
    });
  }

  void sendRiderData(LocationData currentLocation) async {
    var manager = StorageManager();
    var user = await manager.getUser();
    var phone = await manager.getPhone();
    var token = await manager.getFcmToken();
    var image = await manager.getProfileImage();
    var type = getVehicleDetailValue(vehicleModel);
    if (type != null) {
      await firestore.collection("vehicles").document("${phone}").setData({
        "id": user.id,
        "name": user.name,
        "lat": currentLocation.latitude,
        "lng": currentLocation.longitude,
        "fcm": token,
        "vehicleType": type.name,
        "basefare": type.basefare,
        "fare": type.fare,
        "capacity": type.capcity,
        "riderProfile": image,
      });
    }
  }

  getProfileData() async {
    var manager = StorageManager();
    var idss = await manager.getPhone();

    Firestore.instance
        .collection('riders')
        .document('$idss')
        .get()
        .then((DocumentSnapshot data) {
      name = data['name'];
      city = data['city'];
      email = data['email'];
      gender = data['gender'];
      phone = data['phone'];
      profile = data['profile'];
      userVechiclePublicOrPrivate = data['publicOrPrivate'];

      vehicleModel = data['vehicleModel'];
      vehicleName = data['vehicleName'];
      vehicleNumber = data['vehicleNumber'];
      vehicleYear = data['vehicleYear'];

      licenseNumber = data['licenseNumber'];
      licensePhoto = data['licensePhoto'];
      licenseExpiryDate = data['licenseExpiryDate'];

      blueNookFrontPhoto = data['blueBookFrontPhoto'];
      blueBookBackPhoto = data['blueBookBackPhoto'];
      StorageManager().setUserName(name);
      StorageManager().setProfileImage(profile);
      StorageManager().setPhoneNumber(phone);
    });
  }

  getVehicleData() async {
    firestore
        .collection('setvehicletype')
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
      // requestRider(doc["fcm"]);
      print("basefare: ${doc["base_fare"]}");
      print("vehicle:${doc["vehicle"]}");
      //  print("fcm: ${doc["fcm"]}");
    }));
  }

  Types getVehicleDetailValue(String value) {
    switch (value) {
      case "Two-wheeler":
        return Types("Bike", 1, 15, 30);
      case "Four-wheeler":
        return Types("Car", 3, 25, 60);
      case "Four-wheeler-Deluxe":
        return Types("Car-deluxe", 3, 35, 90);
    }
  }
}

class Types {
  String name;
  int capcity;
  int fare;
  int basefare;

  Types(this.name, this.capcity, this.fare, this.basefare);
}








class MyData {
  String gender;
  double lat, lng;
  MyData(this.gender, this.lat, this.lng);
}
