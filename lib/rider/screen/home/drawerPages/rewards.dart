import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/rider/screen/home/drawer.dart';
class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        backgroundColor: AppColor.onLineColor,
        leading: InkWell(
            onTap: () {
//              _drawerKey.currentState.openDrawer();
              Navigator.pop(context);
            },
            child: Icon(Icons.close,color: Colors.black,)),
        title: Text('Rewards',style: TextStyle(color: Colors.black)),
        actions: <Widget>[

          InkWell(
            onTap: () {
//              dwa
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: <Widget>[
                  Text('Edit',style: TextStyle(color: Colors.black),),
                  SizedBox(width: 8,),
                  Icon(Icons.edit,size: 17,color: Colors.black,),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerPage(tag: 'Rewards'),
      ),
      body: Container(
        color:AppColor.onLineColor,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(38),
                  ),
                border: Border.all(width: 4,color: Colors.white)
              ),
              child: Column(
                children: <Widget>[
                  Text('Silver Rewards',style: TextStyle(
                    color: Colors.white,fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('0',style: TextStyle(
                        color: Colors.white,fontSize: 70,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Points Balance',style: TextStyle(
                          color: Colors.black,fontSize: 17,
                          fontWeight: FontWeight.w600
                      ),),
                      SizedBox(width: 5,),
                      Icon(Icons.error,color: Colors.black,size: 20,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child:
                    Text.rich(
                      TextSpan(
                        text: 'Subject to ',
                        style: TextStyle(fontSize: 14,color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'terms and conditions',
                              style: TextStyle(
                                decoration: TextDecoration.underline,fontSize: 14,color: Colors.black
                              )),
                          // can add more TextSpans here...
                        ],
                      ),
                    )

//                    Text('Subject to Terms and conditions',style: TextStyle(
//                        color: Colors.black,fontSize: 14,


                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:2.0),
                  child: Text('Activity',style: TextStyle(
                      color: Colors.white,fontSize: 20,
                  ),),
                ),
                SizedBox(width: 5,),
                Icon(Icons.arrow_forward,color: Colors.white,size: 32,)
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 1.2, color: Colors.white,),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Your Progress',style: TextStyle(
                      color: Colors.white,fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(top: 5,bottom: 15),
                    child: Text('Earn 100 more points to get silver rewards',style: TextStyle(
                      color: Colors.black,fontSize: 14,
                    ),),
                  ),
                  Text('May 2020 - Sept 2020',style: TextStyle(
                      color: Colors.black,fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 0),
              height: 1.2, color: Colors.white,),
            
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.lock,color: Colors.white,size: 25,),
                  SizedBox(width: 5,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text('Silver Rewards',style: TextStyle(
                        color: Colors.white,fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),),
                      Text('100 Points',style: TextStyle(
                        color: Colors.white,fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Award(title:'silver'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0),
              height: 1.2, color: Colors.white,),
            Padding(padding: EdgeInsets.fromLTRB(30, 9, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Redeem points for ride credit',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)
              ],
            ),),
            Container(
              margin: EdgeInsets.symmetric(vertical: 9),
              height: 1.2, color: Colors.white,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Get 50% discount on servicing',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                    Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)
                  ],
                ),),
            Container(
              margin: EdgeInsets.symmetric(vertical: 9),
              height: 1.2, color: Colors.white,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Award from guru of the months',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)
                ],
              ),),
            Container(
              margin: EdgeInsets.symmetric(vertical: 9),
              height: 1.2, color: Colors.white,),

            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.lock,color: Colors.white,size: 25,),
                  SizedBox(width: 5,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Silver Rewards',style: TextStyle(
                          color: Colors.white,fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),),
                      Text('100 Points',style: TextStyle(
                          color: Colors.white,fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Award(title:'golden'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 9),
              height: 1.2, color: Colors.white,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text('Redeem points for ride credit',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600))),
            Container(
              margin: EdgeInsets.symmetric(vertical: 9),
              height: 1.2, color: Colors.white,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text('Get 50% discount on servicing',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600))),
            Container(
              margin: EdgeInsets.symmetric(vertical: 9),
              height: 1.2, color: Colors.white,),
          ],
        ),

      ),
    );
  }
}

class Award extends StatelessWidget {
  Award({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 160,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white
      ),
      child: title == 'silver' ? Image.asset('assets/images/silver.png',height: 130,):
      Image.asset('assets/images/gold.png',height: 120,),
    );
  }
}







