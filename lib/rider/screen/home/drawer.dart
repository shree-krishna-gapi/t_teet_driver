import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/earnings.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/help.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/learningCenter.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/profile.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/rewards.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/scheduled.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/settings.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/summary.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/yourTrip.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Constants.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';

import 'drawerPages/vehicle.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({this.tag});

  final String tag;

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  initState() {
    getProfileData();
    super.initState();
  }

  String profile = Constants.PLACEHOLDER;
  String name = "";

  double iconWidth = 27.5;
  double heightPadding = 10.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
//          Positioned(child: Text('Version 1.0',style: TextStyle(color: AppColor.colorPrimary),),
//            bottom: 25, left: 25,),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: AppColor.colorPrimary,
                height: 185,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 34),
                            height: 90,
                            width: 90,
                            decoration: new BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              },
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: "$profile",
                                  fit: BoxFit.fill,
//                                  placeholder: (context, url) => Image.asset('',fit: BoxFit.fill,),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: new BoxDecoration(
                                  color: AppColor.onLineColor,
                                  shape: BoxShape.circle),
                              padding: EdgeInsets.all(2.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColor.onLineColor,
                                  ),
                                ),
                              ),
                            ),
                            bottom: 0,
                            right: 0,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 2),
                          child: Text(
                            '$name',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                        ),
                        Text(
                          'View Profile',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ),
//              Container(color: Colors.black38, height: 1,),
              Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    color: widget.tag == 'Home' ? Colors.black12 : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: (){Navigator.pop(context);},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Image.asset(
                                    'assets/images/home2.png',
                                    color: AppColor.colorPrimary,
                                    height: 22,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Home",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color: widget.tag == 'Scheduled'
                        ? Colors.black12
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scheduled()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Image.asset(
                                    'assets/images/stering.png',
                                    color: AppColor.colorPrimary,
                                    height: 23,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Scheduled Pick Up",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color:
                        widget.tag == 'Rewards' ? Colors.black12 : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Image.asset(
                                    'assets/images/reward.png',
                                    color: AppColor.colorPrimary,
                                    height: 24,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Rewards",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Rewards()));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color:
                        widget.tag == 'Summary' ? Colors.black12 : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Summary()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Image.asset(
                                    'assets/images/summary.png',
                                    color: AppColor.colorPrimary,
                                    height: 21,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Summary",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color: widget.tag == 'Earnings'
                        ? Colors.black12
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Earnings()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Image.asset(
                                    'assets/images/db.png',
                                    color: AppColor.colorPrimary,
                                    height: 25,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Earnings",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color:
                        widget.tag == 'History' ? Colors.black12 : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YourTrip()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Image.asset(
                                    'assets/images/history.png',
                                    color: AppColor.colorPrimary,
                                    height: 24,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Your Trips",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color: widget.tag == 'Documents'
                        ? Colors.black12
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Image.asset(
                                    'assets/images/multipleDoc.png',
                                    color: AppColor.colorPrimary,
                                    height: 25,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Documents",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color:
                        widget.tag == 'Vehicle' ? Colors.black12 : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Vehicle()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  height: 25,
                                  width: 25,
                                  padding: EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: AppColor.colorPrimary),
                                      borderRadius: BorderRadius.circular(90)),
                                  child: Container(
                                      width: iconWidth,
                                      child: Image.asset(
                                        'assets/images/vechile.png',
                                        color: AppColor.colorPrimary,
                                      ))),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Vehicle",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color: widget.tag == 'Learning'
                        ? Colors.black12
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LearningCenter()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Image.asset(
                                    'assets/images/document.png',
                                    color: AppColor.colorPrimary,
                                    height: 24,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Learning Center",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color: widget.tag == 'Settings'
                        ? Colors.black12
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Icon(
                                    Icons.settings,
                                    color: AppColor.colorPrimary,
                                    size: 24,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Settings",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedHeight,
                  ),
                  Container(
                    color: widget.tag == 'Help' ? Colors.black12 : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Help()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: iconWidth,
                                  child: Image.asset(
                                    'assets/images/help.png',
                                    color: AppColor.colorPrimary,
                                    height: 23,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Help",
                                  style: listStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 35),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Version 1.0',
                            style: TextStyle(
                                color: AppColor.colorPrimary, fontSize: 13)),
                      ))
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  final listStyle = TextStyle(
    color: Colors.black,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
    fontSize: 14
  );
  final double sizedHeight = 0.0;

  void getProfileData() {
    StorageManager().getUserName().then((value) {
      setState(() {
        name = value;
      });
    });
    StorageManager().getProfileImage().then((value) {
      setState(() {
        profile = value;
      });
    });
  }
}
