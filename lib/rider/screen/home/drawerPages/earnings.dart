import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/rider/screen/home/drawer.dart';
import 'package:percent_indicator/percent_indicator.dart';
class Earnings extends StatefulWidget {
  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () {
//                _drawerKey.currentState.openDrawer();
                Navigator.pop(context);
              },
              child: Icon(Icons.close,color: Colors.black,)),
          title: Text('Earnings',style: TextStyle(color: Colors.black)),
          actions: <Widget>[

            InkWell(
              onTap: () {
//              dwa
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(Icons.calendar_today,size: 17,color: Colors.black,),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: DrawerPage(tag: 'Earnings'),
        ),
        floatingActionButton: Container(height: 35,
          width: 100,
          child: FloatingActionButton.extended(
            onPressed: () {},
            icon: ImageIcon(AssetImage('assets/images/filtering.png',),size: 18,),
            label: Text("Filter",),
            backgroundColor: AppColor.colorPrimary,
          ),),
        body: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300],width: 1.3)
                  ),),
//                height: 235,


                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("NRs.",style: rstextStyle,),Text("45,350", style: rsboldtextStyle,),Text(".53",style: rstextStyle,)
                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("57 rides in 21 hr 18 min", style: ridestextStyle,)
                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            margin: EdgeInsets.fromLTRB(0,20.0,0,2.0),
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            color: AppColor.colorPrimary,
                            child: (Row( children: <Widget>[
                              Padding(
                                padding:EdgeInsets.all(16.0),
                                child: (Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:<Widget>[
                                      Text("Wallet Balance: NRs.",style: TextStyle(
                                        fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600,
                                        letterSpacing: 0.4
                                      ),),
                                      SizedBox(width: 5,),
                                      Text("-360.00",style: TextStyle(
                                          fontSize: 18,color: AppColor.offLineColor,
                                        fontWeight: FontWeight.w700,
                                          letterSpacing: 0.4,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 1.0,
                                            color: Colors.white
                                          ),

                                        ],
                                      ),),
                                    ])),),



                            ],

                            )),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(10.0,15.0,0,0.0),
                            child:
                            Icon(Icons.error,
                              color: Colors.black,
                              size: 26.0,
                            ), ),],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("See Earning History", style: ehistorytextStyle,),
//                      Padding(padding:EdgeInsets.fromLTRB(2,9.0,0,0),
//                        child: Icon(FontAwesomeIcons.chevronRight,
//                          color: Colors.grey[300],
//                          size: 18.0,
//
//                        ),
//                      ),],),
                        ],)

                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Text('Ride challanges',style: TextStyle(color: Colors.black,
                fontSize: 18),),
              ),
              Container(
                  padding: EdgeInsets.all(15.0),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.verylightPrimary,
                    borderRadius: BorderRadius.all(
                        Radius.circular(22.0) //         <--- border radius here
                    ),
                  ),
                  child: (Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Text("NRs.1600 ride challange", style: ridechallangetextStyle,),
                    Text("End at Monday", style: ridechallangetextStyle2,),
                    SizedBox(height: 10,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ProgressCircle(),
                          ProgressCircle(),

                        ])]))),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Ride challanges',style: TextStyle(color: Colors.black,
                        fontSize: 18),),
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_forward_ios,size: 20,color: Colors.black54,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
                child: Container(
                  height: 1,
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Today',style: TextStyle(color: Colors.black,
                            fontSize: 16,fontWeight: FontWeight.w600),),
                        SizedBox(width: 5,),
                        Text('March 6',style: TextStyle(color: Colors.black45,
                            fontSize: 16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Text('NRs. 1200.00',style: TextStyle(color: Colors.black,
                        fontSize: 16,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    BoxContainer(),BoxContainer(),BoxContainer(),
                  ],
                ),
              ),
              SizedBox(height: 40,),
















            ])

    );


  }




  final ridechallangetextStyle0 = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    letterSpacing: 0.2,
    fontSize: 18,
    height: 1,
    wordSpacing: 1.0,
  );
  final ridechallangetextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
    letterSpacing: 0.2,
    fontSize: 18,
    height: 1.6,
    wordSpacing: 1.0,
  );
  final ridechallangetextStyle2 = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    letterSpacing: 0.3,
    fontSize: 16,
    height: 1.6,
    wordSpacing: 1.0,
  );

  final rstextStyle = TextStyle(
    color: AppColor.colorPrimary,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 22,
    height: 3.5,
    wordSpacing: 1,
  );
  final rsboldtextStyle = TextStyle(
    color: AppColor.colorPrimary,
    fontWeight: FontWeight.w900,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 54,
    height: 1.5,
    wordSpacing: 1,
  );
  final ridestextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0,
    fontSize: 14,
    height: 1.0,
    wordSpacing: 1.0,
  );
  final cardtextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0,
    fontSize: 16,
    height: 1.0,
    wordSpacing: 1.0,
  );
  final cardredtextStyle = TextStyle(
    color: AppColor.offLineColor,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0,
    fontSize: 18,
    height: 1.0,
    wordSpacing: 1.0,
  );
  final ehistorytextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0,
    fontSize: 16,
    height: 2.0,
    wordSpacing: 1.0,
  );

}




class ProgressCircle extends StatelessWidget {
  final ridechallangetextStyle0 = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    letterSpacing: 0.2,
    fontSize: 18,
    height: 1,
    wordSpacing: 1.0,
  );
  final ridechallangetextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w900,
    fontFamily: 'Roboto',
    letterSpacing: 0.2,
    fontSize: 18,
    height: 1.6,
    wordSpacing: 1.0,
  );
  final ridechallangetextStyle2 = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    letterSpacing: 0.3,
    fontSize: 16,
    height: 1.6,
    wordSpacing: 1.0,
  );

  final rstextStyle = TextStyle(
    color: AppColor.colorPrimary,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 22,
    height: 3.5,
    wordSpacing: 1,
  );
  final rsboldtextStyle = TextStyle(
    color: AppColor.colorPrimary,
    fontWeight: FontWeight.w900,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 54,
    height: 1.5,
    wordSpacing: 1,
  );
  final ridestextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0,
    fontSize: 14,
    height: 1.0,
    wordSpacing: 1.0,
  );
  final cardtextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0,
    fontSize: 16,
    height: 1.0,
    wordSpacing: 1.0,
  );
  final cardredtextStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0,
    fontSize: 16,
    height: 1.0,
    wordSpacing: 1.0,
  );
  final ehistorytextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0,
    fontSize: 16,
    height: 2.0,
    wordSpacing: 1.0,
  );
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 100.0,
      animation: true,
      animationDuration: 1200,
      lineWidth: 8.0,
      percent: 0.3,
      center: Container(
        height: 85,
        width: 85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(90),
            ),
            color: AppColor.colorPrimary
        ),
        child: new Column(
          children: <Widget>[
            new Text ("NR.s", textAlign: TextAlign.left, style:
            new TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Colors.white,height: 3),),
            new Text ("650", textAlign: TextAlign.left, style:
            new TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0, color: Colors.white,height: 1),),
          ],

        ),
      ),
      footer: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: new Text ("10/10", textAlign: TextAlign.left, style:
            new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,
                color: AppColor.colorPrimary,height:0.5),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: new Text ("Completed", textAlign: TextAlign.left, style:
            new TextStyle(fontSize: 11, color: Colors.black,height: 1),),
          ),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: Colors.lightGreen[100],
      progressColor: Colors.white,

    );
  }
}


class BoxContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(12)
          ),
          color: AppColor.verylightPrimary
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Rides',style: TextStyle(color: Colors.black54,fontSize: 15,fontWeight: FontWeight.w600),),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text('13',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
          )
        ],
      ),
    );
  }
}

