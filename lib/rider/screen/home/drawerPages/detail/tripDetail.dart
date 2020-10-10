import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Colors.dart';

class TripDetail extends StatefulWidget {
  @override
  _TripDetailState createState() => _TripDetailState();
}

class _TripDetailState extends State<TripDetail> {
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
                          child: Text("Trip Detail",
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
        ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(15,10,15,10),
                  child: Row(
                    children: [
                      Expanded(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text("Trip ID",style: TextStyle(color: Colors.black54,fontSize: 13.0, fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                             SizedBox(height: 2,),
                              Text("#82MFC6",style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600,letterSpacing: 0.2),),
                            ],

                          )

                      ),
                      Icon(Icons.content_copy, color: Colors.black, size: 20.0,)

                    ],

                  ),
                ),

              ],
            ),

          ),
          Card(

            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding:EdgeInsets.all(0),  child: Text("Trip Info",style: TextStyle(color: Colors.black87,fontSize: 16.0, fontWeight: FontWeight.w700),),),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.2,
                                color: Colors.black87),
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                        child: Row(
                          children: [
                          Icon(Icons.directions_bike,size: 14,),
                            SizedBox(width: 4,),
                            Text('BIKE',style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600,
                            letterSpacing: 0.2),)
                          ],
                        ),)
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text("01 Jan 2020, 02:04 PM",style:
                  TextStyle(color: Colors.black87,fontSize: 15.0, fontWeight: FontWeight.w400),),

                  Padding(padding: EdgeInsets.only(top: 10,bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          decoration:  new BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle
                          ),
                          height: 8, width: 8,
                        ),
                        Expanded(child: Padding(padding:EdgeInsets.fromLTRB(8,0,0,0),  child: Text("Joon Montessori School, Golfutar, Main Roa, Buddhanilkantha",style: TextStyle(color: Colors.black54,fontSize: 12.0, ),),)),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          decoration:  new BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                          ),
                          height: 8, width: 8,
                        ),
                        Expanded(child: Padding(padding:EdgeInsets.fromLTRB(8,0,0,0),
                          child: Text("Dasrat Rangasala Stadium, KanthiPath, Tripureshwor Chowk, KTM",style:
                          TextStyle(color: Colors.black54,fontSize: 12.0, ),),),),
                      ],
                    )

                  ),

                ],
              ),
            ),

          ),
          Card(
            child: Padding(padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,width: 60,
                        decoration: new BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                            BorderRadius.all(Radius.circular(90))),
                        child: ClipOval(
                          child: Image.asset('assets/images/started.jpg',),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("Trija Tamang",style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Row(
                    children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 4),
                       child: Image.asset('assets/images/starRating.png', height: 15,),
                     ),Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Image.asset('assets/images/starRating.png', height: 15,),
                      ),Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Image.asset('assets/images/starRating.png', height: 15,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Image.asset('assets/images/starRating.png', height: 15,),
                      ),
                    ],
                  )

                ],

              ),
            ),
          ),
          Card(
            child: ExpansionTile(
              title: new Text('REQUEST AGAIN',style: new TextStyle(fontSize: 15.0,
                fontWeight: FontWeight.w500, color: Colors.red),),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: new Column(
                    children: <Widget>[
                      RaisedButton(onPressed: (){
                      },
                        color: Colors.orange,
                        child: Text('Hello World',style: TextStyle(color: Colors.white),),
                      )

                    ],
                  ),
                ),
              ],
            ),

          ),
          Card(

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Text("Receipt",style: TextStyle(color: Colors.black87,fontSize: 15.0, fontWeight: FontWeight.w600),),
                        Text("NRs.150.0",style: TextStyle(color: Colors.black87,fontSize: 15.0, fontWeight: FontWeight.bold)
                        )
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Base Fare",style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),),
                      Text("NRs.30.0",style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600)
                      )
                    ],
                  ),
                  SizedBox(height: 7.5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("8.4 Kilometer",style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),),
                      Text("NRs.125.0",style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600)
                      )
                    ],
                  ),
                  SizedBox(height: 7.5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("24.3 Kilometer",style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),),
                      Text("NRs.0.0",style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600)
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(height: 1, color: AppColor.blackBorder,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal",style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),),
                      Text("NRs. 150.0",style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(height: 1, color: AppColor.blackBorder,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Net Fare",style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),),
                      Text("NRs. 150.0",style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)
                      )
                    ],
                  ),
                  SizedBox(height: 2,),
                ],
              ),
            ),

          ),

        ],
      )
    );
  }
}
