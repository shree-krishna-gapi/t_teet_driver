import 'package:flutter/material.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/earnings.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/profile.dart';
import 'package:t_teet_rider/screens/MessageUserListPage.dart';
import 'package:t_teet_rider/screens/PaymentPage.dart';
import 'package:t_teet_rider/screens/MessageUserListPage.dart';
import 'package:t_teet_rider/screens/RiderProfilePage.dart';


import '../utils/Colors.dart';
import 'HomeScreen.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    PaymentPage(),
    MessageUserListPage(),
    Profile()
  ];



  void _onItemTapped(int index) {
switch (index){

  case(0):
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return HomeScreen();
    }));
    break;
  case(1):
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return Earnings();
    }));
    break;
  case(2):
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new MessageUserListPage();
    }));
    break;
  case(3):
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new Profile();
    }));
    break;
}

    }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children:<Widget>[

        BottomNavigationBar(
          elevation: 5.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(

              icon: Icon(Icons.directions_bike, size: 30.0,),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment, size: 30.0,),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.email, size: 30.0,),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add, size: 30.0,),
              title: Text(''),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColor.colorPrimary,
          onTap: _onItemTapped,
          unselectedItemColor: Colors.grey,
        ),


      ]
    );


  }


}
