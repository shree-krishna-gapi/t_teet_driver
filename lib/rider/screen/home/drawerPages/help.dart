import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/rider/screen/home/drawer.dart';
class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
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
        title: Text('Help',style: TextStyle(color: Colors.black)),

      ),
      drawer: Drawer(
        child: DrawerPage(tag:'Help'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text('Get approve romotely',style: TextStyle(
                    color: AppColor.colorPrimary,fontSize: 18
                  ),),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: AppColor.colorPrimary,
                      child: InkWell(
                        onTap: (){},
                        splashColor: AppColor.splashColorPrimary,
                        child: Container(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Align(alignment: Alignment.center ,child:
                          Text('Take online test',style: TextStyle(
                              fontSize: 24,color: Colors.white
                          ),)),
                        ),width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('Recommended for you',style: TextStyle(
                      fontSize: 26,fontWeight: FontWeight.w700
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: Text("Can't request a ride",style: TextStyle(
                    fontSize: 17
                  ),
                  ),
                ),
                Container(
                  height: 1, color: Colors.black26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: Text("Can't request a ride",style: TextStyle(
                      fontSize: 17
                  ),
                  ),
                ),
                Container(
                  height: 1, color: Colors.black26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: Text("Can't request a ride",style: TextStyle(
                      fontSize: 17
                  ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('Get help',style: TextStyle(
                      fontSize: 26,fontWeight: FontWeight.w700
                  )),
                ),
                Container(
                  height: 560,
                  padding: EdgeInsets.all(15.0),
                  color:Colors.white,
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: helpList == null ? 0 : helpList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                        crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 2, color: Colors.black12
                          )
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Expanded(child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft:  const  Radius.circular(10.0),
                                      topRight:  const  Radius.circular(10.0),
                                    ),
                                    color: Colors.black12,
                                  ),
                                  width: double.infinity,),flex: 2,),
                                Expanded(child: Container(
                                    padding: EdgeInsets.fromLTRB(20,30,20,10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('${helpList[index]['title']}',style:
                                        TextStyle(
                                          fontSize: 14,fontWeight: FontWeight.w600,
                                        ),textAlign: TextAlign.center,),
                                    )),flex: 3,)
                              ],
                            ),
                            Positioned(child: Container(
                                padding: EdgeInsets.fromLTRB(40,7,40,15)
                                ,child: Image.asset('${helpList[index]['image']}',fit: BoxFit.cover,)),
                              top: 7,left: 0,right: 0,
                            ),



                          ],
                        ),
                      );
                    },
                  ),

                ),
              ],
            ),

          ),

        ],
      ),
    );
  }
  List helpList = [
    {
      'id': 0,
      'title': 'Free, charges and fees',
      'type': '',
      'value': 'NRs. 85,200',
      'image': 'assets/images/help1.png'
    },
    {
      'id': 1,
      'title': 'Profile and account settings',
      'type': '',
      'value': 'NRs. 85,200',
      'image': 'assets/images/help1.png'
    },
    {
      'id': 2,
      'title': 'Promos, credits and rewards',
      'type': '',
      'value': '120',
      'image': 'assets/images/help1.png'
    },
    {
      'id': 3,
      'title': 'Something happened on my ride',
      'type': 'km',
      'value': '8,350',
      'image': 'assets/images/help1.png'
    },
    {
      'id': 4,
      'title': 'Report Safety',
      'type': '',
      'value': '6,23',
      'image': 'assets/images/help1.png'
    }
  ];
}

class Award extends StatelessWidget {
  Award({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white
      ),

    );
  }
}







