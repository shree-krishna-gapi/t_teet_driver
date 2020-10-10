import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_teet_rider/screens/SplashScreen.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/rider/screen/home/drawer.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
//              _drawerKey.currentState.openDrawer();
              Navigator.pop(context);
            },
            child: Icon(Icons.close,color: Colors.black,)),
        title: Text('Settings',style: TextStyle(color: Colors.black)),

      ),
      drawer: Drawer(
        child: DrawerPage(tag: 'Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Container(
//              height: 24,width: 24,
              padding: EdgeInsets.all(3),
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black),
                child: Icon(Icons.person,color: Colors.white,size: 18,)),
            title: Text('Prajwal',style: TextStyle(color: Colors.black),),
            subtitle: Text('July 2020'),
          ),
          Container(height: 4,color: Colors.black12,),
          ListTile(
             leading: Icon(Icons.payment,color: Colors.black,),
            title: Text('Payment',style: TextStyle(color: Colors.black),),
          ),
          Container(height: 4,color: Colors.black12,),
          ListTile(
             leading: Container(
    height: 24,
    width: 24,
    padding: EdgeInsets.all(3.5),
    decoration: BoxDecoration(
    border: Border.all(
    width: 1.22,
    color: Colors.black),
    borderRadius: BorderRadius.circular(90)),
    child: Container(
    width: 24,
    child: Image.asset(
    'assets/images/vechile.png',
    color: Colors.black,
    ))),
            title: Text('Vehicle Info',style: TextStyle(color: Colors.black),),
          ),
          Container(height: 4,color: Colors.black12,),
          ListTile(
             leading: Image.asset(
          'assets/images/driverDoc.PNG', width: 24,
    color: Colors.black,
    ),
            title: Text('License and Bluebook Information',style: TextStyle(color: Colors.black),),
          ),
          Container(height: 4,color: Colors.black12,),
          ListTile(
             leading: Image.asset(
    'assets/images/highAlert.PNG', width: 24, height: 24,
    color: Colors.black,
    ),
            title: Text('High earning alert',style: TextStyle(color: Colors.black),),
          ),
          Container(height: 4,color: Colors.black12,),
          ListTile(
            leading: Image.asset(
    'assets/images/vechile.png', width: 20, height: 20,
    color: Colors.black,
    ),
            title: Text('Emergency Contact',style: TextStyle(color: Colors.black),),
          ),
          Container(height: 4,color: Colors.black12,),
          ListTile(
            title: Text('Privacy',style: TextStyle(color: Colors.black),),
            subtitle: Text('Choose what data you share with us'),
          ),
          Container(height: 4,color: Colors.black12,),
          ListTile(

            title: Text('Legal',style: TextStyle(color: Colors.black),),
          ),
          Container(height: 4,color: Colors.black12,),
          ListTile(
            onTap: logoutUser,
            title: Text('Log Out',style: TextStyle(color: Colors.black),),
          ),
          Container(height: 4,color: Colors.black12,),

        ],
      ),
    );
  }
  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.clear();
    Navigator.of(context).pushAndRemoveUntil(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => SplashPage(),
        ),
    (Route route) => false,
    );
  }
}









