import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t_teet_rider/models/RideRequest.dart';
import 'package:t_teet_rider/screens/RatingCustomer.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/models/InvoiceModel.dart';


class InvoicePage extends StatefulWidget {
  RideRequest rideRequest;

  InvoicePage(this.rideRequest);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {


  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(27.6667, 85.3500),
    zoom: 14.4746,
  );
  GoogleMapController _controller;

  List<Marker> myMarkers = [];


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Stack(
          children: <Widget>[
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              cameraTargetBounds : CameraTargetBounds.unbounded,
              initialCameraPosition: initialLocation,
//            markers: Set.of((marker != null) ? [marker] : []),
//            circles: Set.of((circle != null) ? [circle] : []),
              onTap: _handleTap,
              markers: Set.from(myMarkers),
//            onMapCreated: (GoogleMapController controller) {
//              _controller = controller;
//            },


            ),
            Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(

                      width: width,
                      decoration: BoxDecoration(
                          color: AppColor.colorPrimary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0))),
                      child: Column(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColor.colorPrimary,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24.0),
                                      topRight: Radius.circular(24.0))),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: width * 0.1,
                                      ),
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        width: width * 0.05,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Text(
                                            "You Are On Destination",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: height * 0.005,
                                          ),
                                          Text(
                                            "Please Confirm the payment with customer",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 8),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24.0),
                                    topRight: Radius.circular(24.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.02,right: width*0.04),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[

                                      Row(children: [
                                        Icon(
                                          Icons.receipt,
                                          color: AppColor.colorPrimary,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          width: width*0.02,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Customer Id:"),
                                            Text("${widget.rideRequest.id}",style: TextStyle(fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                      ],),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text("Trip Id:"),
                                          Text("#81238",style: TextStyle(fontWeight: FontWeight.w500)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Receipt",style: TextStyle(fontWeight: FontWeight.w500)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text("Time Taken"),
                                          Text("10 min",style: TextStyle(fontWeight: FontWeight.w500))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: height*0.02,),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Base Fare"),
                                      Text("${widget.rideRequest.basefare}")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("${widget.rideRequest.distance} kilometers"),
                                      Text("Nrs. ${widget.rideRequest.distance *(widget.rideRequest.fare)}")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Waiting Amount"),
                                      Text("Nrs 0")
                                    ],
                                  ),
                                ),
                                SizedBox(height: height*0.02,),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Sub Total",style: TextStyle(fontWeight: FontWeight.w500),),
                                      Text("Nrs. ${widget.rideRequest.basefare + (widget.rideRequest.distance *(widget.rideRequest.fare))}",style: TextStyle(fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(
                                    height: 1.0,
                                    width: width * 0.95,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Total",style: TextStyle(fontWeight: FontWeight.w500),),
                                      Text("Nrs.${widget.rideRequest.basefare + (widget.rideRequest.distance *(widget.rideRequest.fare))}",style: TextStyle(fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(
                                    height: 1.0,
                                    width: width * 0.95,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Payment : " ,style: TextStyle(fontWeight: FontWeight.w500),),
                                      Text("${widget.rideRequest.paymentType}",style: TextStyle(fontWeight: FontWeight.w500,color: AppColor.colorPrimary))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height*0.04,
                                ),
                                Center(
                                  child: Container(
                                    child: SizedBox(
                                      height: height * 0.08,
                                      width: width * 0.7,
                                      child: RaisedButton(
                                        elevation: 0.0,
                                        child: Text(
                                            "Received Payment",
                                            style:TextStyle(fontSize: 25.0,)
                                        ),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => RatingCustomer(widget.rideRequest)),
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              height * 0.1),
                                        ),
                                        color: AppColor.colorPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.1,),

                              ],
                            ),
                          )


                        ],
                      )),
                )
              ],
            ),

          ]

      ),

    );
  }



  _handleTap(LatLng tappedPoint){
    print(tappedPoint);
    setState((){
      myMarkers = [];
      myMarkers.add(
          Marker(
              markerId: MarkerId(tappedPoint.toString()),
              position: tappedPoint,
              draggable: true,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
              onDragEnd:(dragEndPosition){
                print(dragEndPosition);
              }
          )
      );

    });
  }
}











