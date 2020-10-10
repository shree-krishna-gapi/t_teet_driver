import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t_teet_rider/models/RideRequest.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingCustomer extends StatefulWidget {
  RideRequest rideRequest;

  RatingCustomer(this.rideRequest);

  @override
  _RatingCustomerState createState() => _RatingCustomerState();
}

class _RatingCustomerState extends State<RatingCustomer> {

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(27.6667, 85.3500),
    zoom: 14.4746,
  );
  GoogleMapController _controller;

  List<Marker> myMarkers = [];

  var _rating;


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
                  height: height * 0.55,
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
                                height: height * 0.01,
                              ),

                              Center(
                                child: Container(
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: new BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              alignment: Alignment.center,
                                              image: NetworkImage(
                                                  Constants.PLACEHOLDER),
                                              fit: BoxFit.fill)),
                                    )),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "${widget.rideRequest.name}",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    "4.6",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Silver Driver",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                            ],
                          )),
                      Expanded(
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.0),
                                  topRight: Radius.circular(24.0))),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(
                                "Ratings your riding experience with ${widget.rideRequest.name}",
                                style: TextStyle(color: Colors.grey),
                              ),
                              RatingBar(
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                  print(rating);
                                },
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  height: 2.0,
                                  width: width * 0.95,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Center(
                                child: Container(
                                  child: SizedBox(
                                    height: height * 0.08,
                                    width: width * 0.7,
                                    child: RaisedButton(
                                      elevation: 0.0,
                                      child: Text(
                                          "Done",
                                          style:TextStyle(fontSize: 30.0,)

                                      ),
                                      textColor: Colors.white,
                                      onPressed: () {
                                        print(_rating);
                                        Navigator.pushNamed(context, '/home');

                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            height * 0.1),
                                      ),
                                      color: AppColor.colorPrimary,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
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









