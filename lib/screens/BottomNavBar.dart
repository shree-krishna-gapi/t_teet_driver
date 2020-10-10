import 'package:flutter/material.dart';
import 'package:t_teet_rider/screens/MessageUserListPage.dart';
import 'package:t_teet_rider/screens/PaymentPage.dart';
import 'package:t_teet_rider/screens/MessageUserListPage.dart';
import 'package:t_teet_rider/screens/RiderProfilePage.dart';


import '../utils/Colors.dart';
import 'HomeScreen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    PaymentPage(),
    MessageUserListPage(),
    RiderProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _widgetOptions[index];
    });
  }



  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );


  }


}
