import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/fadeAnimation.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/rider/screen/home/drawer.dart';
class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
//  getProfileData()async {
//    var manager = StorageManager();
//    var phone = await manager.getPhone();
//    Firestore.instance
//        .collection('summary')
//        .document(phone)
//        .get()
//        .then((value) {
//        print(value.runtimeType);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        backgroundColor: AppColor.verylightPrimary,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close,color: Colors.black,)),
        title: Text('Summary',style: TextStyle(color: Colors.black)),

      ),
      drawer: Drawer(
        child: DrawerPage(tag: 'Summary'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        color:AppColor.verylightPrimary,
        child: StreamBuilder(
//            stream: Firestore.instance.collection('summary').document('+9779808603897').snapshots(),
            stream: Firestore.instance.collection('summary').snapshots(),
            builder: (context,snapshot) {
            if(!snapshot.hasData) return Center(child: Text('loading...'));
            return GridView.count(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              children: [
                Box(title: summaryList[0]['title'],value:snapshot.data.documents[0]['totalrevenue']
                    ,type:summaryList[0]['type']),
                Box(title: summaryList[1]['title'],value:snapshot.data.documents[0]['revenueofmonth']
                    ,type:summaryList[1]['type']),
                Box(title: summaryList[2]['title'],value:snapshot.data.documents[0]['totalnoride']
                    ,type:summaryList[2]['type']),
                Box(title: summaryList[3]['title'],value:snapshot.data.documents[0]['traveldistance']
                    ,type:summaryList[3]['type']),
                Box(title: summaryList[4]['title'],value:snapshot.data.documents[0]['completeride']
                    ,type:summaryList[4]['type']),
                Box(title: summaryList[5]['title'],value:snapshot.data.documents[0]['cancelride']
                    ,type:summaryList[5]['type']),
              ],
            );
        }),
      ),
    );
  }

  List summaryList = [
    {
      'id': 0,
      'title': 'Total Revenue',
      'type': 'nrs',
      'value': 'Nrs. 3,240'
    },
    {
      'id': 1,
      'title': 'Revenue of the month',
      'type': 'nrs',
      'value': 'Nrs. 240'
    },
    {
      'id': 2,
      'title': 'Total No of ride',
      'type': '',
      'value': '120'
    },
    {
      'id': 3,
      'title': 'Total Travel Distance',
      'type': 'km',
      'value': '8,350'
    },
    {
      'id': 4,
      'title': 'Total Complete Rides',
      'type': '',
      'value': '6,23'
    },
    {
      'id': 5,
      'title': 'Cancel Rides',
      'type': '',
      'value': '3'
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




class Box extends StatelessWidget {
  Box({this.title,this.value,this.type});
  final String title,type;
  final int value;
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.2, Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: AppColor.greenGridGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('$title',style: TextStyle(
                color: Colors.white, fontSize: 17
            ),textAlign: TextAlign.center,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child:Text(
                    type == 'nrs' ? 'NRs. $value' : '$value'
                    ,style: TextStyle(
                      color: Colors.white, fontSize: 24,fontWeight: FontWeight.w600
                  ),),
                ),



                type == 'km' ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(' km',style: TextStyle(
                      color: Colors.white, fontSize: 14,fontWeight: FontWeight.w600
                  ),),
                ): Text(''),
              ],
            ),

          ],
        ),
      ),
    );
  }
}



