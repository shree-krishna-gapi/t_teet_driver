import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Colors.dart';

import 'detail/tripDetail.dart';

class YourTrip extends StatefulWidget {
  @override
  _YourTripState createState() => _YourTripState();
}

class _YourTripState extends State<YourTrip> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0.0,
          title: GestureDetector(
            onTap:(){Navigator.pop(context);},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text("Your Trip",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),


                  ]
              ),
            ),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            unselectedLabelColor: Colors.black45,
            labelColor: Colors.black,
            tabs: [
              Text('All',style: tabStyle),
              Text('Personal',style: tabStyle),
              Text('Business',style: tabStyle),
            ],indicatorColor: AppColor.colorPrimary,
            labelPadding: EdgeInsets.only(bottom: 4),
            controller: _tabController,
          )),
      body: TabBarView(
        children: [

          Container(
            child: ListView.builder
              (
                itemCount: 25,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TripDetail()));
                        },
                        leading:  Container(
                          height: 40,width: 40,
                          decoration: new BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                              BorderRadius.all(Radius.circular(90))),
                          child: ClipOval(
                            child: Image.asset('assets/images/started.jpg',),
                          ),
                        ),
                        title: Text('jan 23, 2019, 6:45 PM',style: TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 14
                        ),),
                        subtitle: Row(
                          children: [
                            Icon(Icons.person,size: 16,),
                            SizedBox(width: 4,),
                            Text('9:57mi - 14m',style: TextStyle(
                                fontSize: 13
                            ),)
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,size: 16,),
                      ),
                      Container(height: 1, color: AppColor.blackBorder,),
                    ],
                  );
                }
            )
          ),
          Text("This is notification Tab View"),
          Text("This is notification Tab View"),
        ],
        controller: _tabController,
      ),
    );
  }
  final tabStyle = TextStyle(
      fontSize: 17
  );
}
