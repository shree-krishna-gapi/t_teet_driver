import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/rider/screen/home/drawer.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/foundation.dart';
class Scheduled extends StatefulWidget {
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> with SingleTickerProviderStateMixin{
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final List<Tab> tabs = <Tab>[
    new Tab(text: "Featured"),
    new Tab(text: "Popular"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
//              _drawerKey.currentState.openDrawer();
              Navigator.pop(context);
            },
            child: Icon(Icons.close,color: Colors.black,)),
        title: Text('Scheduled Pickups',style: TextStyle(color: Colors.black)),
        bottom: new TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 35.0,
            indicatorColor: Colors.black12,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
//            padding: EdgeInsets.only(bottom: 20)
          ),
          tabs: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Padding(padding: EdgeInsets.fromLTRB(25,10,25,0),
                child: Text('Available Pickups',style: TextStyle(color: Colors.black,fontSize: 14,letterSpacing: 0.4),),),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Padding(padding: EdgeInsets.fromLTRB(25,10,25,0),
                child: Row(
                  children: <Widget>[
                    Text('My Pickups',style: TextStyle(color: Colors.black,fontSize: 14,letterSpacing: 0.4),),
                    SizedBox(width: 5,),
                    Container(child: Align( alignment: Alignment.center,
                      child: Text('3',style: TextStyle(color: Colors.white,
                      fontSize: 12),),
                    ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.colorPrimary
                      ),
                      height: 16,width: 16,
                    )
                  ],
                ),),
            ),
          ],
          controller: _tabController,
        ),
      ),
      drawer: Drawer(
        child: DrawerPage(tag:'Scheduled'),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: tabs.map((Tab tab) {
          return new ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context,index) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black12,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('Trip', style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w600,letterSpacing: 0.4)),
                            ),
                            Text('Today', style: TextStyle(fontSize: 15,color: Colors.black,letterSpacing: 0.5,fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text('Trip ID', style: TextStyle(fontSize: 12,color: Colors.black)),
                                  Text('#00DF95', style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w600)),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 30,
                              margin: EdgeInsets.only(right: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  BorderRadio(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: GreenDots(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: GreenDots(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: GreenDots(),
                                  ),
//                                  Image.asset('assets/images/location.png',color: Colors.greenAccent,
//                                    height: 22,)
                                  Image.asset('assets/images/location.png',color: AppColor.colorPrimary,height: 24,)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 80,
                                width: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Baneshor Chakrapath',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                                          Text('Kathmandu, Nepal',style: TextStyle(color: Colors.black,fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.2),),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text('Pickup',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                                          Text('10:45 AM',style: TextStyle(color: Colors.black,fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.2),),
                                        ],
                                      )
                                    ],
                                  ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Baneshor Chakrapath',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                                            Text('Kathmandu, Nepal',style: TextStyle(color: Colors.black,fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.2),),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text('Pickup',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                                            Text('10:45 AM',style: TextStyle(color: Colors.black,fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.2),),
                                          ],
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.fromLTRB(10,7,15,7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            color: AppColor.colorPrimary
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('10:30 AM',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,letterSpacing: 0.2,
                              fontSize: 15
                              ),),
                              Text('10:30 AM',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,letterSpacing: 0.2,
                                  fontSize: 15
                              ),),
                              Text('NRs. 150.00',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,letterSpacing: 0.2,
                                  fontSize: 15
                              ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4,)
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }
}







